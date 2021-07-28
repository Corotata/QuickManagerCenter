
USER=$(whoami) open /Users/${USER}/Library/Caches/CocoaPods/Pods/External/ QuickManagerCenter
pod trunk push ./QuickManagerCenter.podspec --verbose --allow-warnings --use-libraries
