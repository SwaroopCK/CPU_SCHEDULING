<%@ page language="java" import="java.util.*,java.util.stream.*,java.lang.*"%>

<%
    String nos = request.getParameter("nos");
    String arrivalTime = request.getParameter("arrivalTime");
    String burstTime = request.getParameter("burstTime");
	String q_no = request.getParameter("qno");
    
    String arrivalTimeStrArr[] = arrivalTime.split(",");
    String burstTimeStrArr[] = burstTime.split(",");

    int intNos = Integer.parseInt(nos);
    int intAT[] = new int[intNos];
    int intBT[] = new int[intNos];
	int qno;

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
	qno=Integer.parseInt(q_no);
	
	sortArrivalTime(out,intAT,intBT,qno);
    RRAlgorithm(out,intAT,intBT,qno);
	
%>

<%!
    public static void displayArr(JspWriter out,int[] arr)throws Exception{
        for(int i = 0; i < arr.length; ++i){
            out.println("<br> => " +arr[i]);
        }
    }
%>

<%!
    public static void sortArrivalTime(JspWriter out,int[] at,int[] bt ,int qno) throws Exception{
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
	static int x;
	public static int getProcess(JspWriter out,int cnt)throws Exception
	{
		int p1;
		if(x==cnt)
			x=0;
		p1=x;
		x++;
		
		return p1;
	}
    public static void RRAlgorithm(JspWriter out,int at[],int bt[],int qno)throws Exception{
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
		int tq=0;
		
		for(i=0;i<bt.length;i++)
			tbt[i]=bt[i];
		
		int currenttime=0;
		String previousprocess=null;
        //------------------------
        float totalTAT = 0.0f;
        float totalWT = 0.0f;
		String ganttChart = "Hello";
		String output="";
		try{
			i=0;
       while(true){
			tq=0;
			
			
            if(currenttime<at[i])
			{
				currentprocess="idle";
				if(currentprocess!=previousprocess)
				{
					
					output+=currenttime+" | "+currenttime+" idle ";
				}
				previousprocess=currentprocess;
				currenttime=at[i];	
			}
			else
			{
				i=getProcess(out,nos);
				if(tbt[i]==0)
					tq=qno;
				while(tq!=qno){
				tbt[i]--;
				st[i]=currenttime;
				currentprocess="P"+i+" ";
				if(currentprocess!=previousprocess)
				{
					output+=currenttime+" | "+currenttime+" "+currentprocess;
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
				if(tbt[i]==0 && tq!=qno)
					break;
				tq++;
				}
				if(cnt==nos) break;

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
		}catch(Exception e){out.println(e);}
    }
%>