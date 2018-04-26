package gov.usgs.cida.gcmrcservices.jsl.lookup;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import gov.usgs.webservices.jdbc.routing.InvalidServiceException;
import gov.usgs.webservices.jdbc.routing.UriRouter;
import gov.usgs.webservices.jdbc.service.WebService;
import gov.usgs.webservices.jdbc.spec.Spec;

/**
 *
 * @author dmsibley
 */
public class LookupService extends WebService {
	private static final long serialVersionUID = -6262978570828134415L;
	
	@SuppressWarnings("unused")
	private static final Logger log = LoggerFactory.getLogger(LookupService.class);

	public LookupService() {
		this.specMapping.put("ancillary", AncillarySpec.class);
	}

	@Override
	protected Map<String, String[]> defineParameters(HttpServletRequest req, UriRouter router, Map<String, String[]> params) throws InvalidServiceException {
		Map<String, String[]> result = new HashMap<String, String[]>();
		
		result.putAll(super.defineParameters(req, router, params));
		
		return result;
	}
	
	@Override
	protected void checkForValidParams(Spec spec) {
		//empty method to allow for query without search parameters
	}
	
}
