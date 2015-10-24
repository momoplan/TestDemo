# #!/bin/sh
# security create-keychain -p travis ios-build.keychain
# security import ./scripts/certs/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
# security import ./scripts/certs/dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
# security import ./scripts/certs/dist.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign
# mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
# cp ./scripts/profile/$PROFILE_NAME.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/


#!/bin/sh

KEY_CHAIN=ios-build.keychain
security create-keychain -p travis $KEY_CHAIN
# Make the keychain the default so identities are found
security default-keychain -s $KEY_CHAIN
# Unlock the keychain
security unlock-keychain -p travis $KEY_CHAIN
# Set keychain locking timeout to 3600 seconds
security set-keychain-settings -t 3600 -u $KEY_CHAIN
security import ./scripts/certs/apple.cer -k /Users/travis/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/certs/dist.cer -k /Users/travis/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
# Add certificates to keychain and allow codesign to access them
# security import ./scripts/certs/dist.cer -k $KEY_CHAIN -T /usr/bin/codesign
# security import ./scripts/certs/dev.cer -k $KEY_CHAIN -T /usr/bin/codesign

# security import ./scripts/certs/dist.p12 -k $KEY_CHAIN -P $KEY_PASSWORD  -T /usr/bin/codesign
# security import ./scripts/certs/dev.p12 -k $KEY_CHAIN -P $KEY_PASSWORD  -T /usr/bin/codesign

# echo "list keychains: "
# security list-keychains
# echo " ****** "

echo "find indentities keychains: "
security find-identity -p codesigning  ~/Library/Keychains/ios-build.keychain
echo " ****** "

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

# cp "./scripts/profiles/iOSTeam_Provisioning_Profile_.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
cp "./scripts/profiles/$PROFILE_NAME.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
