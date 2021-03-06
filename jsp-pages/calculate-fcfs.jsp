<%@ page language="java" import="java.util.*,java.util.stream.*"%>

<%
    String nos = request.getParameter("nos");
    String arrivalTime = request.getParameter("arrivalTime");
    String burstTime = request.getParameter("burstTime");
    
    String arrivalTimeStrArr[] = arrivalTime.split(",");
    String burstTimeStrArr[] = burstTime.split(",");

    int intNos = Integer.parseInt(nos);
    int intAT[] = new int[intNos];
    int intBT[] = new int[intNos];

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
	sortArrivalTime(out, intAT, intBT);
    fcfsAlgorithm(out,intAT,intBT);
	
%>

<%!
    public static void displayArr(JspWriter out, int[] arr)throws Exception{
        for(int i = 0; i < arr.length; ++i){
            out.println("<br> => " +arr[i]);
        }
    }
%>

<%!
    public static void sortArrivalTime(JspWriter out, int[] at, int[] bt) throws Exception{
		int b,t;
        for(int i = 0; i < at.length;i++){
			for(int j=i+1;j<at.length;j++)
				if(at[i]>at[j])
				{
					t=at[i];
					b=bt[i];
					at[i]=at[j];
					bt[i]=bt[j];
					at[j]=t;
					bt[j]=b;
				}
        }
    }
%>

<%!
    public static void fcfsAlgorithm(JspWriter out,int at[],int bt[])throws Exception{
        int time = 0;
        int i = 0;
		int cnt=0;
		int nos=at.length;
        //----Array Declaration---
        int st[] = new int[nos];
        int wt[] = new int[nos];
        int ft[] = new int[nos];
        int tat[] = new int[nos];
		int currenttime=0;
        //------------------------
        
        float totalTAT = 0.0f;
        float totalWT = 0.0f;
		String ganttChart = "";
        i=0;
        while(true){ 
            if(currenttime<at[i])
			{
				ganttChart+=currenttime+" idle ";
				currenttime=at[i];
				ganttChart+=currenttime+" | ";
			}
			else
			{
				ganttChart+=currenttime;
				st[i]=currenttime;
				wt[i]=currenttime-at[i];
				currenttime=currenttime+bt[i];
				tat[i]=wt[i]+bt[i];
				ganttChart+=" P"+i+" "+currenttime+" |";
				totalTAT+=tat[i];
				totalWT+=wt[i];
				ft[i]=currenttime;
				i++;
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