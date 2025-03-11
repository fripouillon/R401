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
	urlPatterns = { "/controller" }, asyncSupported = true
)
public class MyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/** Le modèle. */
	private MyModel m_model = new MyModel() ;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest _request, HttpServletResponse _response)
	 */
	@Override
	protected void doGet(HttpServletRequest _request, HttpServletResponse _response) throws ServletException, IOException {
		sayHello(_request, _response) ;
	}
	
	/**
	 *	Dit bonjour.
	 *	@param _request La requête.
	 *	@param _response La réponse.
	 */
	public void sayHello(HttpServletRequest _request, HttpServletResponse _response) throws ServletException, IOException {
		// TODO: On récupère les paramètres d'entrée 
		// TODO: On modifie les données du modèle 
	}
}
