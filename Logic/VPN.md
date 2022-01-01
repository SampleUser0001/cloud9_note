# VPN

- [VPN](#vpn)
  - [モード](#モード)
    - [トランスポートモード](#トランスポートモード)
    - [トンネルモード](#トンネルモード)
  - [プロトコル](#プロトコル)
    - [IPsec](#ipsec)
      - [IKE (Internet Key Exchange)](#ike-internet-key-exchange)
    - [その他](#その他)
      - [PPTP (Point to Point Tunneling Protocol)](#pptp-point-to-point-tunneling-protocol)

## モード

### トランスポートモード

通信を行う端末が直接データの暗号化を行う。  
通信経路のすべてが暗号化されるが、ペイロード（データ部のみ）の暗号化なので、IPアドレスは暗号化されないため通信先の盗聴は可能。

### トンネルモード

VPNゲートウェイを拠点にして、その間の通信を暗号化する。  
IPsecを使用して、実際の通信先へのパケットを暗号化（カプセル化）し、そのデータにVPNゲートウェイ宛のヘッダを付与して通信する。

## プロトコル

### IPsec

ネットワーク層で暗号化、認証、改ざんの検出を行う。通常のIP通信では利用しないパラメータを交換するが、IPヘッダに入り切らないため、IPsec用のフィールドが用意される。

- AH (Authentication Header)
  - 認証だけを行うときに用いられる。
- ESP (Encapsulating Security Payload)
  - 認証と暗号化を行うときに用いられる。

#### IKE (Internet Key Exchange)

IPSecでは通信を開始する前に、暗号化方式の決定と鍵交換を行う。このフェーズをIKEという。  
UDPの500番ポートを使用する。

### その他

#### PPTP (Point to Point Tunneling Protocol)

データリンク層で暗号化や認証を行うプロトコル。  
IPsecが使えない環境でもVPN接続を構築できる。