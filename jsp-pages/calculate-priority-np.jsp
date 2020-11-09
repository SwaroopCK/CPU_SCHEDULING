<%@ page language="java" import="java.util.*,java.util.stream.*"%>

<%
    String nos = request.getParameter("nos");
    String arrivalTime = request.getParameter("arrivalTime");
    String burstTime = request.getParameter("burstTime");
    String priority = request.getParameter("priority");
	
    String arrivalTimeStrArr[] = arrivalTime.split(",");
    String burstTimeStrArr[] = burstTime.split(",");
	String priorityStrArr[] = priority.split(",");
	
    int intNos = Integer.parseInt(nos);
    int intAT[] = new int[intNos];
    int intBT[] = new int[intNos];
	int intPRIORITY [] = new int[intNos];
	
    //Converting string array to int array
    int i = 0;
    for(String num : arrivalTimeStrArr){
        intAT[i] = Integer.parseInt(num);
        ++i;
    }
    
    //Converting string array to int array
    i = 0;
    for(String num : burstTimeStrArr){
        intBT[i] = Integer.parseInt(num);
        ++i;
    }
	
	i = 0;
    for(String num : priorityStrArr){
        intPRIORITY[i] = Integer.parseInt(num);
        ++i;
    }

	sortArrivalTime(out, intAT, intBT,intPRIORITY);
    priorityAlgorithm(out,intAT,intBT,intPRIORITY);
	
%>

<%!
    public static void displayArr(JspWriter out, int[] arr)throws Exception{
        for(int i = 0; i < arr.length; ++i){
            out.println("<br> => " +arr[i]);
        }
    }
%>

<%!
    public static void sortArrivalTime(JspWriter out, int[] at, int[] bt,int[] priority) throws Exception{
		int b,t,p;
        for(int i = 0; i < at.length;i++){
			for(int j=i+1;j<at.length;j++)
				if(at[i]>at[j])
				{
					t=at[i];
					b=bt[i];
					p=priority[i];
					at[i]=at[j];
					bt[i]=bt[j];
					priority[i]=priority[j];
					at[j]=t;
					bt[j]=b;
					priority[j]=p;
				}
        }
    }
%>

<%!

	public static int getProcess(int at[],int bt[],int tbt[],int[] priority,int currenttime)
	{
		int i,min=9999,p1=-1;
		for(i=0;i<at.length;i++)
		{
			if(at[i]<=currenttime && tbt[i]!=0)
			{
				if(priority[i]<min)
				{
					min=priority[i];
					p1=i;
				}
			}
		}
		return p1;
	}
    public static void priorityAlgorithm(JspWriter out,int at[],int bt[],int[] priority)throws Exception{
        int time = 0;
        int i = 0;
		int cnt=0;
		int nos=at.length;
        //----Array Declaration---
        int st[] = new int[nos];
        int wt[] = new int[nos];
        int ft[] = new int[nos];
        int tat[] = new int[nos];
		int tbt[] = new int[nos];
		
		for(i=0;i<bt.length;i++)
			tbt[i]=bt[i];
		
		int currenttime=0;
        //------------------------
        
        float totalTAT = 0.0f;
        float totalWT = 0.0f;
		String ganttChart = "";
        while(true){
			i=getProcess(at,bt,tbt,priority,currenttime);
            if(i==-1)
			{
				ganttChart+=currenttime+" idle ";
				currenttime=at[cnt];
				ganttChart+=currenttime+" | ";
			}
			else
			{
				ganttChart+=currenttime;
				st[i]=currenttime;
				wt[i]=currenttime-at[i];
				currenttime=currenttime+bt[i];
				tbt[i]=0;
				tat[i]=wt[i]+bt[i];
				ganttChart+=" P"+i+" "+currenttime+" |";
				totalTAT+=tat[i];
				totalWT+=wt[i];
				ft[i]=currenttime;
				cnt++;
				if(cnt==nos) break;
			}
        }
        i = 0;
        for(i=0;i<at.length;i++){
            String tableData = "<tr>"+
                                   "<td>P"+i+"</td>"+
                                   "<td>"+at[i]+"</td>"+
                                   "<td>"+bt[i]+"</td>"+
                                   "<td>"+st[i]+"</td>"+
                                   "<td>"+ft[i]+"</td>"+
                                   "<td>"+wt[i]+"</td>"+
                                   "<td>"+tat[i]+"</td>"+
                               "</tr>";
            out.println(tableData);
        }
        String timeData = "<tr>"+
                            "<td><b>Result:</b></td>"+
                          "</tr>"+
                          "<tr>"+
                            "<td><b>Total Waiting Time</b></td>"+
                            "<td>"+totalWT+"</td>"+
                          "</tr>"+
                          "<tr>"+
                            "<td><b>Total Turn Around Time</b></td>"+
                            "<td>"+totalTAT+"</td>"+
                          "</tr>"+
                          "<tr>"+
                            "<td><b>Average Waiting Time</b></td>"+
                            "<td>"+(totalWT/nos)+"</td>"+
                          "</tr>"+
                          "<tr>"+
                            "<td><b>Average Turn Around Time</b></td>"+
                            "<td>"+(totalTAT/nos)+"</td>"+
                          "</tr>";
        out.println(timeData);
        
        
        
        String ganttChartData = "<tr>"+
                                "<td><b> Gantt Chart </b></td>"+
                                "</tr>"+
                                "<tr>"+
                                    "<td>"+ganttChart+"</td>"+
                                "</tr>";
        out.println(ganttChartData);
    }
%>