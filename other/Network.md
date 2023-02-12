# Network

- [Network](#network)
  - [CIDR(Classless Inter-Domain Routing)](#cidrclassless-inter-domain-routing)
  - [NAT(Network Address Translation)](#natnetwork-address-translation)
  - [NAPT(IPマスカレード)](#naptipマスカレード)

## CIDR(Classless Inter-Domain Routing)

クラスによってネットワークアドレス部と、ホストアドレス部を分割すると、使用されないホストアドレスが増える。  
そこで、サブネットマスクによってネットワークアドレス部をネットワークサイズに応じて任意の長さに変更できるようになった。

## NAT(Network Address Translation)

グローバルIPアドレスとプライベートIPアドレスを1対1で紐づける。

## NAPT(IPマスカレード)

1つのグローバルIPアドレスと、複数のプライベートIPアドレスを紐づける技術。  
グローバルIPアドレス:ポート番号と、プライベートIPアドレスを紐づける。

