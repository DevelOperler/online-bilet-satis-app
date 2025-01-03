# Flutter için Base Image
FROM cirrusci/flutter:stable AS build

# Çalışma dizinini ayarla
WORKDIR /app

# Bağımlılıkları yükle
COPY pubspec.* ./
RUN flutter pub get

# Uygulama kaynaklarını kopyala
COPY . .

# Release build al
RUN flutter build web

# Web server için Base Image
FROM nginx:alpine

# Flutter build çıktılarını NGINX'e kopyala
COPY --from=build /app/build/web /usr/share/nginx/html

# NGINX'i çalıştır
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
