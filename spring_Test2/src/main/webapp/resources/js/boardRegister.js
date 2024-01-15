console.log("boardRegister in");

// 트리거 버튼 처리
document.getElementById("trigger").addEventListener("click", () => {
    document.getElementById("files").click();
});

// 실행파일, 이미지 파일, 파일 최대 사이즈 정규표현식 작성
const regExp = new RegExp(".(exe|sh|bat|dll}jar|msi)$"); // 실행파일 패턴
const maxSize = 1024 * 1024 * 20; // 파일 최대 크기
//Validation : 규칙설정
//return 0 / 1로 리턴
function fileValidation(fileName, fileSize) {
    if (regExp.test(fileName)) {
        //파일이름이 실행파일인지 확인
        return 0;
    } else if (fileSize > maxSize) {
        return 0;
    } else {
        return 1;
    }
}

// 첨부파일에 따라서 등로 가능한지 체크 함수
// 여러개의 파일이 배열로 들어옴
// 한번 true가 되면 다시 false로 돌아올수 없음. 버튼 활성화
// 기존 추가했던 파일 삭제
// fileValidation 함수의 리턴 여부를 체크.
// 모든 파일이 1이여야 가능
// *(곱하기)로 처리를 하여 모든 파일이 1이어야 통과
// 한 파일에 대한 결과
// 소문자 처리
// 업로드 가능 여부 표시
// 업로드 불가능한 파일이 1개라도 있다면....
// '1'이 true'0'이 faulse

document.addEventListener("change", (e) => {
    console.log(e.target);
    if (e.target.id === "files") {
        //여러개의 파일이 배열로 들어옴
        const fileobject = document.getElementById("files").files;
        console.log(fileobject);

        //  한번 disabled되면 혼자 풀어질 수 없음. 버틍을 원해 상태로 복구
        document.getElementById("regBtn").disabled = false;

        // 첨부파일에 대한 정보를 fileZone에 기록
        let div = document.getElementById("fileZone");
        div.innerHTML = "";
        //ul > li 로 값을 추가

        // * 여러파일에 대한 검증을 모두 통과하기 위해서
        // *로 각 파일마다 통과여부를 확인
        let isOk = 1; // 전체 파일 검증 결과
        let ul = `<ul class="list-group list gruop-flush">`;
        for (let file of fileobject) {
            // 개별파일의검증 결과
            let ValidResult = fileValidation(file.name, file.size);
            isOk *= ValidResult;
            ul += `<li class="list-group-item">`;
            ul += `<div class="mb-3"> `;
            ul += `${
                ValidResult
                    ? '<div class="fw-bold"> 업로드 가능</div>'
                    : '<div class="fw-bold text-danger"> 업로드 불가능</div>'
            }`;
            ul += `${file.name}</div>`;
            ul += `<span class="badge rounded-pill text-bg-${
                ValidResult ? "success" : "danger"
            }">${file.size}Byte</span>`;
            ul += `</li>`;
        }
        ul += `</ul>`;
        div.innerHTML = ul;

        if (isOk == 0) {
            //하나의 파일이라도 검증에 통과하지 못한다면 버트 비활성화
            document.getElementById("regBtn").disabled = true;
        }
    }
});

// document.getElementById("regBtn").disabled = false;가 없었을 경우
//한번 disabled선언된 후 다시 자동 갱신이 안된 상태이므로 위 구문을 추가하여 .......
// 추가 갱신f5 하지 않아도 레지스터 버튼 자동 활성화
