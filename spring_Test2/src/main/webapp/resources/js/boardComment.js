console.log("comment js in");
console.log(">>>>bnoVal>>>>>>" + bnoVal);

document.getElementById("cmtPostBtn").addEventListener("click", () => {
    const cmtText = document.getElementById("cmtText");
    if (cmtText.value == null || cmtText.value == "") {
        alert("댓글을 입력해주세요.");
        cmtText.focus();
        return false;
    } else {
        let cmtData = {
            bno: bnoVal,
            writer: document.getElementById("cmtWriter").innerText,
            content: cmtText.value,
        };
        console.log("cmtData >> ", cmtData);
        postCommentToServer(cmtData).then((result) => {
            if (result === "1") {
                alert("댓글 등록 성공~");
                cmtText.value = "";
            }
            // 화면에 뿌리기
            spreadCommentList(cmtData.bno);
        });
    }
});

async function postCommentToServer(cmtData) {
    try {
        const url = "/comment/post";
        const config = {
            method: "post",
            headers: {
                "content-type": "application/json; charset=utf-8",
            },
            body: JSON.stringify(cmtData),
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function getCommentListFromServer(bno, page) {
    try {
        const resp = await fetch("/comment/" + bno + "/" + page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

function spreadCommentList(bno, page = 1) {
    getCommentListFromServer(bno, page).then((result) => {
        console.log(result.cmtList);
        const ul = document.getElementById("cmtListArea");
        if (result.cmtList.length > 0) {
            if (page == 1) {
                ul.innerHTML = "";
            }
            for (let cvo of result.cmtList) {
                let li = `<li class="list-group-item" data-cno="${cvo.cno}" data-writer="${cvo.writer}">`;
                li += `<div class="mb-3">`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}`;
                li += `</div>`;
                li += `<span class="badge rounded-pill text-bg-warning">${cvo.modAt}</span><br>`;
                li += `<button type="button" class="btn btn-outline-warning mod" data-bs-toggle="modal" data-bs-target="#myModal">e</button>`;
                li += `<button type="button" class="btn btn-outline-danger del">x</button>`;
                li += `</li>`;
                ul.innerHTML += li;
            }
            let moreBtn = document.getElementById("moreBtn");
            console.log(moreBtn);
            if (result.pgvo.pageNo < result.endPage) {
                moreBtn.style.visibility = "visible";
                moreBtn.dataset.page = page + 1;
            } else {
                moreBtn.style.visibility = "hidden";
            }
        } else {
            let li = `<li class="list-group-item">Comment List Empty</li>`;
            ul.innerHTML += li;
        }
    });
}

document.addEventListener("click", (e) => {
    console.log(e.target);
    if (e.target.id == "moreBtn") {
        let page = parseInt(e.target.dataset.page);
        spreadCommentList(bnoVal, page);
    } else if (e.target.classList.contains("mod")) {
        let li = e.target.closest("li");

        // nextSibling: 한부모 안에서 같은(다음) 형제를 찾아라
        let cmtText = li.querySelector(".fw-bold").nextSibling;
        // cmtText = ${cvo.content}
        console.log(cmtText);
        // 모달창에 기존 댓글 내용을 반영(=> 수정하기 편하게 하기 위해)
        document.getElementById("cmtTextMod").value = cmtText.nodeValue;
        //cmtText.innerText; 가 아닌 cmtText.nodeValue;인 이유? 차이점?

        // '수정'위해 => cno, writer, content 가 필요
        //                  => 이것을 위한 cno,writer, date-로 달기

        document
            .getElementById("cmtModBtn")
            .setAttribute("data-cno", li.dataset.cno);
        document
            .getElementById("cmtModBtn")
            .setAttribute("data-writer", li.dataset.writer);
    } else if (e.target.id == "cmtModBtn") {
        let cmtDataMod = {
            cno: e.target.dataset.cno,
            writer: e.target.dataset.writer,
            content: document.getElementById("cmtTextMod").value,
        };
        console.log(cmtDataMod);
        // 비동기 보내기
        editCommentToServer(cmtDataMod).then((result) => {
            if (result == "1") {
                alert("댓글 수정 완료");
                //모달창을 닫기
                document.querySelector(".btn-close").click();
            } else {
                alert("댓글 수정 실패");
                // 모달창을 닫기
                document.querySelector(".btn-close").click();
            }
            //수정된 댓글 뿌리기 page=1
            spreadCommentList(bnoVal);
        });

        // del기능
    } else if (e.target.classList.contains("del")) {
        let li = e.target.closest("li");
        let cno = li.dataset.cno;
        let writer = li.dataset.writer;
        deleteCommentToServer(cno, writer).then((result) => {
            if (result == "1") {
                alert("댓글을 삭제하였습니다.");
                spreadCommentList(bnoVal);
            }
        });
    }
});

async function editCommentToServer(cmtDataMod) {
    try {
        const url = "/comment/edit";
        const config = {
            method: "put",
            headers: {
                "content-type": "application/json; charset=utf-8",
            },
            body: JSON.stringify(cmtDataMod),
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function deleteCommentToServer(cno, writer) {
    try {
        const url = "/comment/delete/" + cno + "/" + writer;
        const config = {
            method: "delete",
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
