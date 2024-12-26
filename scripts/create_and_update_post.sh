#!/bin/bash
# 경로 설정
SCRIPT_DIR="${HOME}/git/dyumell.github.io/scripts"
# 입력된 제목 확인
TITLE=$1
if [ -z "$TITLE" ]; then
    echo "Usage: new_and_update.sh <title>"
    exit 1
fi
# 1. create_post.sh 실행
CREATE_OUTPUT=$("${SCRIPT_DIR}/create_post.sh" "$TITLE")
if [[ "$CREATE_OUTPUT" =~ New\ post\ created:\ (.+) ]]; then
    NEW_POST_FILE="${BASH_REMATCH[1]}"
    echo "$CREATE_OUTPUT" # 생성 성공 메시지 출력
else
    echo "$CREATE_OUTPUT" # 실패 메시지 출력
    exit 1
fi
# 2. update_post.sh 실행
"${SCRIPT_DIR}/update_post.sh" "$TITLE"
if [ $? -eq 0 ]; then
    echo "Post '$TITLE' has been updated."
else
    echo "Failed to update post '$TITLE'."
    exit 1
fi
