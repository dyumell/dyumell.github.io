#!/bin/bash

# 날짜 추출
DATE=$(date +"%Y-%m-%d %H:%M:%S %z")

# 제목 입력
TITLE=$1

# 제목이 입력되지 않았으면 종료
if [ -z "$TITLE" ]; then
    echo "Usage: $0 <title>"
    exit 1
fi

# 포스트 디렉토리 경로 (대소문자 정확하게 맞추기)
POST_DIR="${HOME}/git/dyumell.github.io/_posts"

# 제목에 해당하는 파일이 이미 존재하는지 확인 (파일명에서 제목을 추출하여 비교)
for FILE in "$POST_DIR"/*; do
    if [[ -f "$FILE" ]]; then
        FILENAME=$(basename "$FILE")  # 경로에서 파일명만 추출
        # 제목 추출 (파일명에서 날짜와 .md를 제외)
        FILE_TITLE=$(echo "$FILENAME" | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//; s/\.md$//')

        # 입력한 제목과 파일에서 추출한 제목이 같으면 중복
        if [ "$TITLE" == "$FILE_TITLE" ]; then
            echo "Post with title '$TITLE' already exists!"
            exit 1  # 중복된 제목이 있을 때 종료
        fi
    fi
done

# 파일 이름 생성
FILENAME="${POST_DIR}/$(date +"%Y-%m-%d")-${TITLE}.md"

# 템플릿 작성
cat > "$FILENAME" << EOF
---
layout: post
title: "$TITLE"
date: ${DATE}
categories:
tags:

---

EOF
