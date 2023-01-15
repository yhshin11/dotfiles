## Simple tutorial

https://aldama.hashnode.dev/kmonad-and-the-power-of-infinite-leader-keys

## More in depth tutorial

https://tilde.team/~contrapunctus/blog/keyboard-machinations-kmonad.html

## Official FAQ (Must read!)

https://github.com/kmonad/kmonad/blob/master/doc/faq.md

## Official config tutorial

https://github.com/kmonad/kmonad/blob/master/keymap/tutorial.kbd

## TL;DR on Ubuntu

- Download latest binary from [github](https://github.com/kmonad/kmonad/releases) and place in $PATH
- Run the following commands

```bash
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
# Add udev rule for uinput
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/90-uinput.rules
# Reload udev rules
sudo udevadm control --reload-rules && sudo udevadm trigger
# Make uinput loadable module
echo uinput | sudo tee /etc/modules-load.d/uinput.conf

```