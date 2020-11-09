function calculateSJFPreemptive(){
    var nos = document.getElementById("no-of-processes").value;
    var arrivalTime = document.getElementById("arrival-time").value;
    var burstTime = document.getElementById("burst-time").value;
    
    var data = "nos="+nos+"&arrivalTime="+arrivalTime+"&burstTime="+burstTime;
    xmlhttp1 = new XMLHttpRequest();
    xmlhttp1.open("GET","/scheduling-algorithms/jsp-pages/calculate-sjf-preemptive.jsp?"+data,true);
    xmlhttp1.send();
    output = xmlhttp1.responseText;
    xmlhttp1.onreadystatechange=function(){
		if(xmlhttp1.readyState==4 && xmlhttp1.status==400){
			document.getElementById("tableRowId").innerHTML = ""+output;
	document.getElementById("process-division").style.display = "block";}};
}