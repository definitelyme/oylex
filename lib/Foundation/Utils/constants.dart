const Pattern emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const Pattern upperCasePattern = "(.*[A-Z].*)";

const Pattern numberPattern = "[0-9]+";

const Pattern symbolPattern =
    "(.*[@!#\$^*()\[\]\\{}%^&+=\"\"\'\'|;:<>-_,.?\/].*)";

const IMAGES_FOLDER = "assets/images/";
const INTRO_IMAGES_FOLDER = "${IMAGES_FOLDER}intro/";
const PERMISSION_IMAGES_FOLDER = "${IMAGES_FOLDER}permisssions/";
