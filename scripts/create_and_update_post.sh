#!/bin/bash

# 제목 입력
TITLE=$1

# 제목이 입력되지 않았으면 종료
if [ -z "$TITLE" ]; then
    echo "Usage: $0 <title>"
    exit 1
fi

# create_post.sh 호출하여 포스트 생성
${HOME}/git/dyumell.github.io/scripts/create_post.sh "$TITLE"

# create_post.sh가 중복 제목으로 종료되었으면 종료
if [ $? -ne 0 ]; then
    exit 1
fi

# 포스트 디렉토리 경로
POST_DIR="${HOME}/git/dyumell.github.io/_posts"

# 제목에 해당하는 파일 경로
FILENAME=$(find "$POST_DIR" -type f -name "*${TITLE}*.md" -print -quit)

# 생성된 포스트 바로 수정
if [ -n "$FILENAME" ]; then
    vim "$FILENAME"
else
    echo "Error: Failed to create post for '$TITLE'."
    exit 1
fi

