function calculateRR(){
    var nos = document.getElementById("no-of-processes").value;
    var arrivalTime = document.getElementById("arrival-time").value;
    var burstTime = document.getElementById("burst-time").value;
    var qno = document.getElementById("q-no").value;
    var data = "nos="+nos+"&arrivalTime="+arrivalTime+"&burstTime="+burstTime+"&qno="+qno;
	
    xmlhttp1 = new XMLHttpRequest();
    xmlhttp1.open("GET","/Project1/jsp-pages/calculate-RR.jsp?"+data,false);
    xmlhttp1.send();
    output = xmlhttp1.responseText;
    
    document.getElementById("tableRowId").innerHTML = ""+output;
    document.getElementById("process-division").style.display = "block";
    
}