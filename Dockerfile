# 안정적인 우분투 베이스 이미지 사용
FROM ubuntu:20.04

# url 설정
ARG url_input
RUN echo $url_input

# 환경 변수로 타임존 설정 (예: Asia/Seoul)
ENV TZ=Asia/Seoul

# 타임존 설정 적용
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# 기본 패키지 설치 (git, curl, build tools, tzdata)
RUN apt-get update && \
    apt-get install -y git curl unzip xz-utils sudo tzdata && \
    apt-get clean

# 플러터 설치
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /usr/local/flutter

# 플러터 경로 설정
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# 플러터 웹 도구 활성화
RUN flutter config --enable-web

# 디펜던시 설치
RUN flutter precache

# 작업 디렉토리 설정
WORKDIR /app

# 깃헙 레포지토리 클론
RUN git clone https://github.com/jibminJung/findYourJob-Frontend.git .

# 필요 패키지 설치
RUN flutter pub get

# 웹용으로 빌드
RUN flutter build web --dart-define=BASE_URL=$url_input

# Nginx 설치
RUN apt-get install -y nginx

# Nginx 설정 파일 수정
RUN rm /etc/nginx/sites-enabled/default
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /app/build/web; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/sites-available/default

# Nginx 설정 활성화
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# 컨테이너 시작 시 Nginx 실행
CMD ["nginx", "-g", "daemon off;"]

# 컨테이너의 80 포트 노출
EXPOSE 80
