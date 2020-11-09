<%@ page language="java" import="java.util.*,java.util.stream.*,java.lang.*"%>

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
    sjfpAlgorithm(out,intAT,intBT);
	
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

	public static int getProcess(int at[],int bt[],int tbt[],int currenttime)
	{
		int i,min=9999,p1=-1;
		for(i=0;i<at.length;i++)
		{
			if(at[i]<=currenttime && tbt[i]!=0)
			{
				if(tbt[i]<min)
				{
					min=tbt[i];
					p1=i;
				}
			}
		}
		return p1;
	}
    public static void sjfpAlgorithm(JspWriter out,int at[],int bt[])throws Exception{
		String currentprocess=null;
		currentprocess="idle";
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
		String previousprocess=null;
        //------------------------
        
        float totalTAT = 0.0f;
        float totalWT = 0.0f;
		String ganttChart = "Hello";
		String output=" "+" idle ";
        while(true){
			i=getProcess(at,bt,tbt,currenttime);
			
            if(i!=-1)
			{
				
				tbt[i]--;
				st[i]=currenttime;
				currentprocess="P"+i+" ";
				if(currentprocess!=previousprocess)
				{
					<!--out.println(ganttChart);
					output+=currenttime+" | "+currenttime+" idle "+currentprocess;
				}
				currenttime++;
				if(tbt[i]==0){
				ft[i]=currenttime;
				tat[i]=ft[i]-at[i];
				wt[i]=tat[i]-bt[i];
				totalTAT+=tat[i];
				totalWT+=wt[i];
				cnt++;
				}
				previousprocess=currentprocess;
				if(cnt==nos) break;
			}
			else
			{
				currentprocess="idle";
				if(currentprocess!=previousprocess)
				{
					
					output+=currenttime+" | "+currenttime+" idle ";
					<!--out.println(ganttChart);
				}
				out.println(currenttime+" | "+currenttime+" "+currentprocess);
				<!--ganttChart+=currenttime+" | "+currenttime+" "+currentprocess;
				previousprocess=currentprocess;
				currenttime++;

			}
        }
		output+=currenttime;
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
        
        
        
        String outputData = "<tr>"+
                                "<td><b> Gantt Chart </b></td>"+
                                "</tr>"+
                                "<tr>"+
                                    "<td>"+output+"</td>"+
                                "</tr>";
        out.println(outputData);
    }
%>