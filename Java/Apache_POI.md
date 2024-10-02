# Apache POI

- [Apache POI](#apache-poi)
  - [基本](#基本)
    - [pom.xml](#pomxml)
      - [log4j2.xml](#log4j2xml)
    - [java](#java)
    - [参考](#参考)
  - [読み込み](#読み込み)
  - [XSSFとSXSSFの違い](#xssfとsxssfの違い)
  - [行数、列数を取得する](#行数列数を取得する)
  - [作成者を変更する](#作成者を変更する)
  - [プログラム名を変更する](#プログラム名を変更する)
  - [getCellValue](#getcellvalue)
    - [参考](#参考-1)
  - [列を削除して詰める](#列を削除して詰める)
  - [読み込み + 更新する](#読み込み--更新する)

## 基本

### pom.xml

- 内部でlog4j2を使用している。

``` xml
  <dependencies>
    <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-api</artifactId>
      <version>${log4j2.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-core</artifactId>
      <version>${log4j2.version}</version>
    </dependency>

    <dependency>
      <groupId>org.apache.poi</groupId>
      <artifactId>poi</artifactId>
      <version>${poi.version}</version>
    </dependency>
    <!-- Excel2007以上（xlsx）をサポートする -->
    <dependency>
      <groupId>org.apache.poi</groupId>
      <artifactId>poi-ooxml</artifactId>
      <version>${poi.version}</version>
    </dependency>

  </dependencies>

```

#### log4j2.xml

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE project> 
<!-- statusでlog4j2自体のログを出力する。通常はoff --> 
<Configuration status="off">

    <!-- Propertiesは、nameの値を変数として使える -->
    <Properties>
        <!-- ログのフォーマット 
           %dは日時。{}に日時の形式を指定
           %tはスレッド名
           %-6pはログレベル名称を左詰めで6文字分出力する。「debug」であれば後ろに空白１文字が追加される。
               但し、%-3pとしても名称は削られず「debug」として出力される。%6と-をとると右づめになる。
           %c{x}は,例えばロガー名がorg.apache.commons.Fooのとき%c{2}の場合、commons.Fooが出力される
           %mはログメッセージ
           %nは改行
        -->
        <Property name="format1">%d{yyyy/MM/dd HH:mm:ss.SSS} [%t] %-6p %c{10} %m%n</Property>
        <Property name="logfile">./logs/testlog.log</Property>
        <Property name="logfile-archive">./logs/testlog_%d{yyyy-MM-dd}.tar.gz</Property>
    </Properties>
    
    <Appenders>
        <!-- コンソールに出力する設定 -->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout>
                <pattern>${format1}</pattern>
            </PatternLayout>
        </Console>

        <!-- ファイルに出力する設定 -->
        <!-- どこかのタイミングでローテートする。filePatternとTimeBasedTriggeringPoliciyに依存。-->
        <RollingFile name="logfile001" append="true" fileName="${logfile}"
            filePattern="${logfile-archive}">
            <PatternLayout>
                <pattern>${format1}</pattern>
            </PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1" modulate="true" />
            </Policies>
        </RollingFile>
    </Appenders>
    
    <Loggers>
        <!-- warn以上のログを出力する。 -->
        <Root level="warn">
            <AppenderRef ref="Console" />
            <AppenderRef ref="logfile001" />
        </Root>
        <!-- LoggerでRootとは別にpackageごとに指定できる。-->
        <Logger name="sample.poi" level="trace" additivity="false">
            <AppenderRef ref="Console" />
            <AppenderRef ref="logfile001" />
        </Logger>
        
    </Loggers>
</Configuration>
```

### java

``` java
package sample.poi;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.nio.file.Paths;
import java.io.FileOutputStream;

import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * Apache POI サンプル
 */
public class App {
    
    private Logger logger = LogManager.getLogger();

    public void exec(String[] args) {
        FileOutputStream fos = null;
        XSSFWorkbook workbook = null;
 
        try {
 
            // ワークブック→シート→行→セルの生成
            workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet();
            XSSFRow row = sheet.createRow(0);
            XSSFCell cell = row.createCell(0);
 
            // セルの書式の生成
            XSSFCellStyle cellStyle = workbook.createCellStyle();
            XSSFFont font = workbook.createFont();
            font.setFontName("ＭＳ ゴシック");
            cellStyle.setFont(font);
            cell.setCellStyle(cellStyle);
 
            // セルに書き込み
            cell.setCellValue("Hello World!");
 
            SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd_HHmmss");
            String exportPath
                = Paths.get(
                    System.getProperty("user.dir") ,
                    "export",
                    String.format("test_%s.xlsx", format.format(new Date()))).toString();
            logger.info("exportPath : {}", exportPath);
 
            // ファイル書き込み
            fos = new FileOutputStream(exportPath);
            workbook.write(fos);
 
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
                if (workbook != null) {
                    workbook.close();
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void main( String[] args ) {
        new App().exec(args);
    }
}
```

### 参考

- [Poi_Sample_Java](https://github.com/SampleUser0001/Poi_Sample_Java)

## 読み込み

- [Read_Excel_Poi:SampleUser0001:Github](https://sampleuser0001.github.io/Read_Excel_Poi/)
- [Poi_WriteReadAppend:SampleUser0001:Github](https://github.com/SampleUser0001/Poi_WriteReadAppend)

## XSSFとSXSSFの違い

- [Apache POIでエクセル操作を作ってみて〜XSSFとSXSSFの違い:ハジカラ](https://kk90info.com/apache-poi%E3%81%A7%E3%82%A8%E3%82%AF%E3%82%BB%E3%83%AB%E6%93%8D%E4%BD%9C%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%A6%E3%81%BF%E3%81%A6%E3%80%9Cxssf%E3%81%A8sxssf%E3%81%AE%E9%81%95%E3%81%84/)

## 行数、列数を取得する

- [Poi_getRowLength_getCellLength](https://github.com/SampleUser0001/Poi_getRowLength_getCellLength)

## 作成者を変更する

デフォルトだと```Apache POI```になるので、それが嫌だという時の対応。

``` java
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

XSSFWorkbook workbook = new XSSFWorkbook();

workbook.getProperties().getCoreProperties().setCreator("ittimfn");
```

## プログラム名を変更する

デフォルトだと```Apache POI```になるので、それが嫌だという時の対応。

``` java
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

XSSFWorkbook workbook = new XSSFWorkbook();

workbook.getProperties().getExtendedProperties().getUnderlyingProperties().setApplication("");
```

## getCellValue

Cellから値を取得する場合、Excel側で指定されている型（書式）によって、使うメソッドが異なる。

``` java
package ittimfn.tool.poi.enums;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.CellType;

import java.math.BigDecimal;

public enum CellTypeEnum {
    NUMERIC(CellType.NUMERIC) { 
        @Override
        public String getCellValue(XSSFCell cell) {
            return 
                DateUtil.isCellDateFormatted(cell) ?
                DATE.getCellValue(cell) : 
                BigDecimal.valueOf(cell.getNumericCellValue()).toPlainString();
        }
    },
    STRING(CellType.STRING) {
        @Override
        public String getCellValue(XSSFCell cell) {
            return cell.getStringCellValue();
        }
    },
    FORMULA(CellType.FORMULA) {
        @Override
        public String getCellValue(XSSFCell cell) {
            return cell.getCellFormula();
        }
    },
    BLANK(CellType.BLANK) {
        @Override
        public String getCellValue(XSSFCell cell) {
            // TODO 機会があれば書く
            return null;
        }

    },
    BOOLEAN(CellType.BOOLEAN) {
        @Override
        public String getCellValue(XSSFCell cell) {
            return Boolean.toString(cell.getBooleanCellValue());
        }
    },
    ERROR(CellType.ERROR) {
        @Override
        public String getCellValue(XSSFCell cell) {
            // TODO 機会があれば書く
            return null;
        }
    },
    DATE(null) {
        @Override
        public String getCellValue(XSSFCell cell) {
            // TODO 機会があれば書く
            // TODO Date -> String変換については形式指定が必要。
            return null;
        }
    };
    
    private CellType cellType;
    
    private CellTypeEnum(CellType cellType) {
        this.cellType = cellType;
    }

    public static CellTypeEnum valueOfCellType(CellType cellType) throws IllegalArgumentException {
        for(CellTypeEnum e : values()) { 
            if(e.cellType == cellType) {
                return e;
            }
        }
        throw new IllegalArgumentException("Not Found : " + cellType);
    }

    public abstract String getCellValue(XSSFCell cell);
}
```

### 参考

- [CellTypeEnum.java:Export_Excel_Width_Poi:SampleUser0001:Github](https://github.com/SampleUser0001/Export_Excel_Width_Poi/blob/main/src/main/java/ittimfn/tool/poi/enums/CellTypeEnum.java)

## 列を削除して詰める

- [CellTypeEnum.java:Poi_delete_and_close:SampleUser0001:Github](https://github.com/SampleUser0001/Poi_delete_and_close/blob/main/src/main/java/ittimfn/poi/enums/CellTypeEnum.java)
    - 実際には残すセルの値を、削除するセルにコピーする。
    - 値コピーは取得 -> 書き込みだが、取得はセルの書式によって呼び出すメソッド変える必要がある点に注意が必要。

## 読み込み + 更新する

読み込みと更新は同時にできない。

1. 元ファイルをtmpディレクトリにコピー
2. tmpファイルをFileInputStream + Workbookで読み込む
3. Workbookを更新
4. FileInputStream.close()
5. tmpファイルをFileOutputStreamで開く
6. Workbook.write(FileOutputStream)で書き込む
7. FileOutputStream.close() + Workbook.close()
8. tmpファイルを元ファイルにコピー

``` java
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelFileCopyAndEdit {
    public static void main(String[] args) {
        // 入力ファイルのパス
        String inputFilePath = "path/to/input/file.xls";
        // 最終的にコピーするパス
        String finalFilePath = "path/to/final/destination/file.xls";

        try {
            // 一時ディレクトリにファイルをコピー
            Path tempDir = Files.createTempDirectory("tempDir");
            Path tempFile = tempDir.resolve("tempFile.xls");
            Files.copy(Paths.get(inputFilePath), tempFile, StandardCopyOption.REPLACE_EXISTING);

            // Apache POIを使用してExcelファイルを読み込み
            FileInputStream fis = new FileInputStream(tempFile.toFile());
            HSSFWorkbook workbook = new HSSFWorkbook(fis);
            HSSFSheet sheet = workbook.getSheetAt(0);

            // ファイルを編集（例として、A1セルに"Hello, World!"と書き込む）
            HSSFRow row = sheet.getRow(0);
            if (row == null) {
                row = sheet.createRow(0);
            }
            HSSFCell cell = row.getCell(0);
            if (cell == null) {
                cell = row.createCell(0);
            }
            cell.setCellValue("Hello, World!");

            // 編集した内容を一時ファイルに上書き保存
            fis.close();
            FileOutputStream fos = new FileOutputStream(tempFile.toFile());
            workbook.write(fos);
            fos.close();
            workbook.close();

            // 編集完了後に、指定のパスにコピー
            Files.copy(tempFile, Paths.get(finalFilePath), StandardCopyOption.REPLACE_EXISTING);

            System.out.println("ファイルのコピーと編集が完了しました。");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

```