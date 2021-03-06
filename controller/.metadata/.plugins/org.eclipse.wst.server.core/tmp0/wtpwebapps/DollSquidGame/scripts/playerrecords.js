const playerTable = document.querySelector(".player-table");

playerTable.addEventListener("click", (e) => {
	e.preventDefault();

	// get the number value of id
	const id = e.target.id.substring(1);
	console.log("log: " + id);

	if (e.target.tagName == "BUTTON" && e.target.className == "update-btn") {
		// get the wins data
		const wins = document.querySelector("#w" + id).textContent;
		updateRecord(id, wins);
		// alert(`log: update button. id:${id} |wins:${wins}`);
	}
	else if (e.target.tagName == "BUTTON" && e.target.className == "delete-btn") {
		deleteRecord(id);
		// alert(`log: delete button. id:${id}`);
	}
});

function updateRecord(id, wins) {
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		console.log("onload test");
	};
	xhttp.open("POST", "records?id=" + id + "&wins=" + wins);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send();
	alert("Record updated!");
	location.reload();
}

function deleteRecord(id) {
	const xhttp = new XMLHttpRequest();
	xhttp.onload = function() {
		console.log("onload test");
	};
	xhttp.open("DELETE", "records?id=" + id);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send();
	alert("Record deleted!");
	location.reload();
}
