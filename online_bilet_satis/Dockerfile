# Flutter için temel imaj
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Çalışma dizinini ayarla
WORKDIR /app

# Bağımlılık dosyalarını kopyala ve bağımlılıkları yükle
COPY pubspec.* ./
RUN flutter pub get

# Uygulama kaynaklarını kopyala
COPY . .

# Web için release build al
RUN flutter build web --release

# NGINX için temel imaj
FROM nginx:alpine

# Flutter build çıktılarını NGINX'e kopyala
COPY --from=build /app/build/web /usr/share/nginx/html

# NGINX'i çalıştır
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
