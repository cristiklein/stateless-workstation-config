# Synchronize clock to ntp.se

This role set up clock synchronization conforming to [Netnod's best practices](https://www.netnod.se/blog/best-practices-connecting-ntp-servers). Specifically:

* Swedish `ntp.se` (Section 2);
* USA [NIST](https://tf.nist.gov/tf-cgi/servers.cgi) (Section 3);
* German [PTB](https://www.ptb.de/cms/en/ptb/fachabteilungen/abtq/gruppe-q4/ref-q42/time-synchronization-of-computers-using-the-network-time-protocol-ntp.html) (Section 3);
* Ubuntu's default NTP servers included in the `chrony` package (Section 4).

This conforms with regulations as stringent as [MSBFS 2020:7 4 kap. 13 §](https://www.msb.se/siteassets/dokument/regler/forfattningar/msbfs-2020-7-foreskrifter-om-sakerhetsatgarder-i-informationssystem-for-statliga-myndigheter.pdf).
