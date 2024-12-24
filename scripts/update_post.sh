#!/bin/bash

# 작업경로 지정
POST_DIR="${HOME}/git/dyumell.github.io/_posts"

# 제목 입력
TITLE=$1

# 제목이 없을 시 -z : 문자열이 비었을 경우
if [ -z "$TITLE" ]; then
        echo "Usage: update_post <title>"
        exit 1 # exit code 1 : 비정상 종료, exit code 0 : 정상 종료
fi

# 파일 경로 생성
FILENAME=$(find "$POST_DIR" -type f -name "*.md" | while read FILE; do
    # 파일명에서 제목 추출 (파일명에서 날짜 및 확장자 제거)
    FILE_TITLE=$(basename "$FILE" | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//; s/\.md$//')

    # 입력받은 제목과 파일에서 추출한 제목이 같으면 그 파일을 반환
    if [ "$TITLE" == "$FILE_TITLE" ]; then
        echo "$FILE"
    fi
done)

# 파일 존재 여부 확인 및 업데이트
if [ -n "$FILENAME" ]; then  # FILENAME이 빈 문자열이 아니면 (제목에 맞는 파일이 있을 때)
        vim "$FILENAME"  # 파일을 vim으로 편집
else
        echo "Error: File '$FILENAME' does not exist."
        exit 1
fi

