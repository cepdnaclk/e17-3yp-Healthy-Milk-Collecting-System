

class ApiUrl{

static String WEB_SERVICE_URL = 'http://192.168.1.101:80/api';

static String REGISTER_URL = WEB_SERVICE_URL + '/register';
static String LOGIN_URL = WEB_SERVICE_URL + '/login';
static String LOGOUT_URL = WEB_SERVICE_URL + '/logout';


static String ADD_DAILY_URL = WEB_SERVICE_URL + '/addDaily';
static String ADD_SUB_URL = WEB_SERVICE_URL + '/addSub';


static String SEND_REQ_URL = WEB_SERVICE_URL + '/sendRequest';
static String ACCEPT_REQ_URL = WEB_SERVICE_URL + '/acceptRequest';



static String FARMER_REQUEST_URL = WEB_SERVICE_URL + '/incomingReqsFromFarmers';
static String CONNECTED_FARMERS_WITH_COLLECTOR_URL = WEB_SERVICE_URL + '/connectedFarmersWithCollector';
static String INACTIVE_COLLECTORS_URL = WEB_SERVICE_URL + '/inactiveCollectors';
static String ACTIVE_COLLECTORS_URL = WEB_SERVICE_URL + '/connectedCollectorsWithFarmer';




static String UPDATE_NAME_URL = WEB_SERVICE_URL + '/updateName';
static String CHANGE_PASSWORD_URL = WEB_SERVICE_URL + '/changePassword';





}