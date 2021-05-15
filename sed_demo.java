import java.rmi.RemoteException

public class HelloClient
{
	/**
	 * @param args
	 */

	public static void main(String[] args)
	{
		//TODO Auto-generated method stub
		    HelloProxy ws = New HelloProxy();
		try
		{
			system.out.println(ws.sayHello("dfsdkfhk"));
		}
		catch (RemoteException e)
		{
			//TODO Auto-generated catch block
			    e.printStackTrace(e)
		}
	}
}
