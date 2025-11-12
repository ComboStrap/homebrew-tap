# Contrib


## How to set up locally

```bash
ORGANISATION=combostrap
mkdir -p /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/$ORGANISATION
mkdir -p $HOME/code/$ORGANISATION
git clone git@github.com:$ORGANISATION/homebrew-tap.git $HOME/code/$ORGANISATION/homebrew-tap
ln -s $HOME/code/$ORGANISATION/homebrew-tap /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/$ORGANISATION/homebrew-tap
```
