#!/bin/sh

LF=$(printf '\\\012_')
LF=${LF%_}
REPOSITORY_NAME="scratch3-qrcode"
EXTENSION_NAME="QR Code"
EXTENSION_ID="qrcode"
COLLABORATOR="Sugiura Lab"
EXTENSION_DESCRIPTION="Scan QR Code.{credit_en}"

cd node_modules/scratch-vm
npm install encoding-japanese@1.0.30
npm install jsqr@1.3.1
cd ../../

mkdir -p node_modules/scratch-vm/src/extensions/scratch3_${EXTENSION_ID}

cp ${REPOSITORY_NAME}/scratch-vm/src/extensions/scratch3_${EXTENSION_ID}/index.js node_modules/scratch-vm/src/extensions/scratch3_${EXTENSION_ID}/

mv node_modules/scratch-vm/src/extension-support/extension-manager.js node_modules/scratch-vm/src/extension-support/extension-manager.js_orig
sed -e "s|class ExtensionManager {$|builtinExtensions['${EXTENSION_ID}'] = () => require('../extensions/scratch3_${EXTENSION_ID}');${LF}${LF}class ExtensionManager {|g" node_modules/scratch-vm/src/extension-support/extension-manager.js_orig > node_modules/scratch-vm/src/extension-support/extension-manager.js

mkdir -p src/lib/libraries/extensions/${EXTENSION_ID}
cp ${REPOSITORY_NAME}/scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/${EXTENSION_ID}.png src/lib/libraries/extensions/${EXTENSION_ID}/
cp ${REPOSITORY_NAME}/scratch-gui/src/lib/libraries/extensions/${EXTENSION_ID}/${EXTENSION_ID}-small.svg src/lib/libraries/extensions/${EXTENSION_ID}/
mv src/lib/libraries/extensions/index.jsx src/lib/libraries/extensions/index.jsx_orig
mv src/containers/extension-library.jsx src/containers/extension-library.jsx_orig
cp ${REPOSITORY_NAME}/scratch-gui/src/containers/extension-library.jsx src/containers/extension-library.jsx
DESCRIPTION="\
    {${LF}\
        name: (${LF}\
            <FormattedMessage${LF}\
                defaultMessage='${EXTENSION_NAME}'${LF}\
                description='Name for the QR Code extension'${LF}\
                id='gui.extension.${EXTENSION_ID}blocks.name'${LF}\
            />${LF}\
        ),${LF}\
        extensionId: '${EXTENSION_ID}',${LF}\
        collaborator: '${COLLABORATOR}',${LF}\
        iconURL: ${EXTENSION_ID}IconURL,${LF}\
        insetIconURL: ${EXTENSION_ID}InsetIconURL,${LF}\
        description: (${LF}\
            <FormattedMessage${LF}\
                defaultMessage='${EXTENSION_DESCRIPTION}'${LF}\
                description='Description for the QR Code extension'${LF}\
                values={{${LF}\
                    credit_ja:<div style={{fontSize: '0.6em'}}>QRコードは株式会社デンソーウェーブの登録商標です。</div>,${LF}\
                    credit_ja_Hira:<div style={{fontSize: '0.6em', lineHeight: '1.3', marginTop: '0.5em'}}>QRコードはかぶしきがいしゃデンソーウェーブのとうろくしょうひょうです。</div>,${LF}\
                    credit_en:<div style={{fontSize: '0.6em'}}>QR Code is a registered trademark of DENSO WAVE.</div>${LF}\
                }}${LF}\
                id='gui.extension.${EXTENSION_ID}blocks.description'${LF}\
            />${LF}\
        ),${LF}\
        featured: true,${LF}\
        disabled: false,${LF}\
        internetConnectionRequired: false,${LF}\
        bluetoothRequired: false,${LF}\
        translationMap: {${LF}\
          'ja': {${LF}\
              'gui.extension.${EXTENSION_ID}blocks.name': 'QRコード',${LF}\
              'gui.extension.${EXTENSION_ID}blocks.description': 'QRコードを読み取ります。{credit_ja}'${LF}\
          },${LF}\
          'ja-Hira': {${LF}\
              'gui.extension.${EXTENSION_ID}blocks.name': 'QRコード',${LF}\
              'gui.extension.${EXTENSION_ID}blocks.description': 'QRコードをよみとります。{credit_ja_Hira}'${LF}\
          }${LF}\
        }${LF}\
    },"
sed -e "s|^export default \[$|import ${EXTENSION_ID}IconURL from './${EXTENSION_ID}/${EXTENSION_ID}.png';${LF}import ${EXTENSION_ID}InsetIconURL from './${EXTENSION_ID}/${EXTENSION_ID}-small.svg';${LF}${LF}export default [${LF}${DESCRIPTION}|g" src/lib/libraries/extensions/index.jsx_orig > src/lib/libraries/extensions/index.jsx
