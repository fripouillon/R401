import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException ;
import jakarta.servlet.annotation.WebServlet ;
import jakarta.servlet.http.HttpServlet ;
import jakarta.servlet.http.HttpServletRequest ;
import jakarta.servlet.http.HttpServletResponse ;

/**
 *	Le contrôleur.
 */
@WebServlet(
)
public class MyServletHello extends HttpServlet {
	/**
	 * @see HttpServlet#doGet(HttpServletRequest _request, HttpServletResponse _response)
	 */
	@Override
	protected void doGet(HttpServletRequest _request, HttpServletResponse _response) throws ServletException, IOException {
	}
}
