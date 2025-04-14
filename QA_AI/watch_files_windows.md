# Windows環境でファイル監視をする

Windows + Git Bashで特定のファイルの変更を監視して、変更時にコマンドを実行したい場合、いくつかのアプローチがあります。

Git Bash環境では、`watch`や`inotifywait`などのLinuxネイティブのファイル監視ツールが使えないため、別の方法を使う必要があります。以下にいくつかの選択肢を示します：

## 1. PowerShellを使った方法

Git Bashから以下のようにPowerShellスクリプトを呼び出すことができます：

```bash
powershell -Command "& {
    $FSWatcher = New-Object System.IO.FileSystemWatcher
    $FSWatcher.Path = '$(pwd -W)'
    $FSWatcher.IncludeSubdirectories = $true
    $FSWatcher.Filter = '*.md'
    $FSWatcher.EnableRaisingEvents = $true
    
    $Action = {
        $path = $Event.SourceEventArgs.FullPath
        $changeType = $Event.SourceEventArgs.ChangeType
        Write-Host \"$path was $changeType\"
        # ここに実行したいコマンドを書く
        # 例: bash -c 'echo \"変更を検出しました: $path\"'
    }
    
    Register-ObjectEvent -InputObject $FSWatcher -EventName Changed -Action $Action
    
    Write-Host 'Watching for changes in MD files. Press Ctrl+C to exit.'
    while ($true) { Start-Sleep -Seconds 1 }
}"
```

## 2. バッチスクリプトでポーリング

単純なポーリングスクリプトを作成する方法もあります：

```bash
#!/bin/bash
# watch_md_changes.sh

# 最初の状態を保存
find . -name "*.md" -type f -exec stat -c "%Y %n" {} \; | sort > /tmp/md_files_state

while true; do
    # 現在の状態を取得
    find . -name "*.md" -type f -exec stat -c "%Y %n" {} \; | sort > /tmp/md_files_state_new
    
    # 変更をチェック
    if ! cmp -s /tmp/md_files_state /tmp/md_files_state_new; then
        echo "MD files changed!"
        # ここに実行したいコマンドを追加
        # 例: echo "変更が検出されました！"
        
        # 状態を更新
        mv /tmp/md_files_state_new /tmp/md_files_state
    else
        rm /tmp/md_files_state_new
    fi
    
    # 一定時間待機（秒数）
    sleep 2
done
```

使い方：
```bash
chmod +x watch_md_changes.sh
./watch_md_changes.sh
```

## 3. Node.jsを使った方法（インストールされている場合）

Node.jsがインストールされている場合は、`fs.watch`を使った簡単なスクリプトを作成できます：

```javascript
// watch_md.js
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

function watchDir(dir) {
    fs.watch(dir, { recursive: true }, (eventType, filename) => {
        if (filename && path.extname(filename) === '.md') {
            console.log(`変更を検出: ${path.join(dir, filename)}`);
            // ここに実行したいコマンドを追加
            exec('echo "MDファイルが変更されました"', (error, stdout, stderr) => {
                if (stdout) console.log(stdout);
                if (stderr) console.error(stderr);
            });
        }
    });
    
    console.log(`Watching directory: ${dir} for MD file changes`);
}

watchDir('.');
```

使い方：
```bash
node watch_md.js
```

## 推奨アプローチ

Windowsでの利便性と信頼性を考えると、PowerShellを使った方法（オプション1）が最も堅牢です。特にサブディレクトリを含む監視と特定のファイル（.md）のみの監視が簡単にできるためです。ただし、実行する必要があるコマンドによっては、必要に応じてスクリプトをカスタマイズしてください。