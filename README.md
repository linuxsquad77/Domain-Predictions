# LINUXSQUAD Username Generator v6.2

Termux X11 Panel için random unique username oluşturucu. 30 farklı platform için 3-15 karakter arası, 100-5000 adet benzersiz kullanıcı adı üretir.

## Özellikler
- 30 platform desteği (TikTok, Instagram, Discord, GitHub vb.)
- 3-15 karakter arası username uzunluğu
- 100-5000 adet unique (benzersiz) username üretimi
- Gerçek zamanlı progress bar (spam yok, tek satırda)
- Çıktıyı .txt dosyasına kaydetme
- Renkli terminal arayüzü

## Kurulum

```bash
pkg update && pkg upgrade -y
pkg install git -y
git clone https://github.com/linuxsquad77/Domain-Predictions.git
cd linuxsquad-username-generator
chmod +x linuxsquad_username_generator.sh
bash linuxsquad_username_generator.sh
