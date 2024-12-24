#!/bin/bash

# shebang 이라는 특별한 구문으로, 스크립트가 어떤 인터프리터를 사용하여 실행될 지 지정 (/bin/bash)
POST_DIR="${HOME}/git/dyumell.github.io/_posts"

# 파일 경로에서 .md 파일을 찾는다.
FILES=$(find "$POST_DIR" -type f -name "*.md")

# 파일마다 날짜, 제목, 마지막 수정 날짜 정보 추출
POSTS=()  # 빈 배열 선언

for FILE in $FILES; do
    # 파일 이름에서 날짜 추출
    FILENAME=$(basename "$FILE")  # 경로에서 파일명만 추출
    TITLE=$(echo "$FILENAME" | sed -E 's/^[0-9]{4}-[0-9]{2}-[0-9]{2}-//; s/\.md$//')  # 제목 추출
    DATE=$(echo "$FILENAME" | sed -E 's/^(....-..-..)-.*$/\1/')  # 날짜 추출
    LAST_MODIFIED_AT=$(stat --format='%y' "$FILE" | cut -d'.' -f1)  # 마지막 수정 날짜 추출
    CREATED_AT=$(stat --format='%W' "$FILE")  # 파일 생성 날짜 (Unix 타임스탬프)

    # Unix 타임스탬프를 사람이 읽을 수 있는 날짜 형식으로 변환
    CREATED_AT_READABLE=$(date -d "@$CREATED_AT" +"%Y-%m-%d %H:%M:%S")
    
    # 배열에 포스트 정보 추가 (CREATED_AT | TITLE | LAST_MODIFIED_AT 순서로 추가)
    POSTS+=("$CREATED_AT_READABLE|$TITLE|$LAST_MODIFIED_AT")
    POSTS+=("")  # 공백을 추가
done

# 제목과 항목에 대한 헤더 출력
printf "%-30s %-30s %-30s\n" "CREATED_AT" "POST_NAME" "LAST_MODIFIED"  # 헤더 출력

# 출력 형식을 맞추기 위해 정렬된 후 포맷 적용
for POST in "${POSTS[@]}"; do
    # 각 포스트 데이터를 받아오기
    CREATED_AT=$(echo "$POST" | cut -d'|' -f1)
    TITLE=$(echo "$POST" | cut -d'|' -f2)
    LAST_MODIFIED_AT=$(echo "$POST" | cut -d'|' -f3)

    # 포맷을 맞추기 위한 출력
    if [ -n "$CREATED_AT" ]; then  # 빈 데이터가 아닐 때만 출력
        printf "%-30s %-30s %-30s\n" "$CREATED_AT" "$TITLE" "$LAST_MODIFIED_AT"
    fi
done | sort -t'|' -k3,3r  # LAST_MODIFIED_AT으로 내림차순 정렬

