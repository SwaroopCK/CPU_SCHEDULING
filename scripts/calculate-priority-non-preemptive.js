function calculatePriorityNP(){
    var nos = document.getElementById("no-of-processes").value;
    var arrivalTime = document.getElementById("arrival-time").value;
    var burstTime = document.getElementById("burst-time").value;
    var priority = document.getElementById("priority").value;
    
    var data = "nos="+nos+"&arrivalTime="+arrivalTime+"&burstTime="+burstTime+"&priority="+priority;
    xmlhttp1 = new XMLHttpRequest();
    xmlhttp1.open("GET","/scheduling-algorithms/jsp-pages/calculate-priority-np.jsp?"+data,false);
    xmlhttp1.send();
    output = xmlhttp1.responseText;
    
    document.getElementById("tableRowId").innerHTML = ""+output;
    document.getElementById("process-division").style.display = "block";
}