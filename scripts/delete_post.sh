#!/bin/bash

# 제목 입력
TITLE=$1

# 작업 경로
POST_DIR="${HOME}/git/dyumell.github.io/_posts"

# 제목만 추출하고 해당 제목에 맞는 파일 찾기 (파일명에서 제목 추출)
FILENAME=$(find "$POST_DIR" -type f -name "*.md" | while read FILE; do
    # 파일명에서 제목 추출 (파일명에서 날짜 및 확장자 제거)
    FILE_TITLE=$(basename "$FILE" | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//; s/\.md$//')

    # 입력받은 제목과 파일에서 추출한 제목이 같으면 그 파일을 반환
    if [ "$TITLE" == "$FILE_TITLE" ]; then
        echo "$FILE"
    fi
done)

# 파일 존재 여부 확인 및 삭제
if [ -n "$FILENAME" ]; then  # FILENAME이 빈 문자열이 아니면 (제목에 맞는 파일이 있을 때)
    rm "$FILENAME"
    echo "Post deleted: $FILENAME"
else
    echo "Post not found: $TITLE"
    exit 1
fi

