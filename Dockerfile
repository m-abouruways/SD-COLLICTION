# المرحلة الأولى: البناء باستخدام Maven و JDK 11
FROM maven:3.8.8-eclipse-temurin-11 AS build
WORKDIR /app

# نسخ الملفات وبناء المشروع
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# المرحلة الثانية: التشغيل باستخدام JRE فقط لتصغير حجم الصورة
FROM eclipse-temurin:11-jre-alpine
WORKDIR /app

# نسخ ملف الـ jar الناتج
COPY --from=build /app/target/commons-collections*.jar ./commons-collections.jar

# أمر التشغيل الافتراضي
CMD ["java", "-jar", "commons-collections.jar"]