ANDROID_JAR=../android-13.jar
AAPT=./../aapt
DX=./../dx
APKBUILDER=./../apkbuilder
mkdir gen
mkdir bin
mkdir bin/classes
$AAPT package -m -J gen/ -M AndroidManifest.xml -S res -I $ANDROID_JAR
$JAVA_HOME/bin/javac -d bin/classes -s bin/classes -cp $ANDROID_JAR gen/com/android/inputmethod/latin/R.java src/com/android/inputmethod/latin/*.java
$DX --dex --output=bin/classes.dex bin/classes/
$AAPT package -f -M AndroidManifest.xml -S res -I $ANDROID_JAR -F bin/kb.apk.unaligned
$APKBUILDER bin/kb.apk -u -f bin/classes.dex -z bin/kb.apk.unaligned
java -jar /mnt/app/apktool/signapk.jar /mnt/app/apktool/testkey.x509.pem /mnt/app/apktool/testkey.pk8 bin/kb.apk bin/kb-signed.apk
