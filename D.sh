wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip -o ngrok-stable-linux-amd64.zip > /dev/null 2>&1
rm -rf ngrok-stable-linux-amd64.zip
read -p "Enter your ngrok token: " TOKEN
./ngrok authtoken $TOKEN
nohup ./ngrok tcp --region ap 5900 &>/dev/null &
sudo apt-get update && apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86-xen -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw windows.img 128G
wget -O RTL8139F.iso 'https://www.dropbox.com/s/v1yyj5i1ao3rtq3/RTL8139F.iso?dl=0https://www.dropbox.com/s/v1yyj5i1ao3rtq3/RTL8139F.iso?dl=1'
wget -O Windows.iso 'https://download2389.mediafire.com/qdgty9iyc8wg/e6gig9u3vo327qk/Tiny+10.iso'

curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 4G \
  -cpu EPYC \
  -boot order=d \
  -drive file=Windows.iso,media=cdrom \
  -drive file=windows.img,format=raw \
  -drive file=RTL8139F.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu core2duo \
  -smp cores=2 \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
