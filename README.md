# scratch3-qrcode

## Installation
This requires you to have Git and Node.js installed.

```bash
# set up scratch-gui
git clone --depth 1 https://github.com/LLK/scratch-gui.git
cd scratch-gui
npm install

# set up QR code extension
git clone https://github.com/sugiura-lab/scratch3-qrcode.git
sh scratch3-qrcode/install.sh
```

## Running
Open a Command Prompt or Terminal in the repository and run:
```bash
npm start
```
Then go to http://localhost:8601/ - the playground outputs the default GUI component

## Release Notes
* 2020.5.18 v1.4 Fix null character issue in binary data
* 2020.5.15 v1.3 Fix font-size of credit
* 2020.5.14 v1.2 Add UTF-16 decoder
* 2020.5.13 v1.1 Add error handling to TextDecoder
* 2020.5.12 v1.0
