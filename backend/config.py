import os

BASE_DIRS = os.path.dirname(__file__)
settings = {
    'debug': True,  # hot refresh
    'gzip': True,  # support gzip compress
    'autoescape': None,
    'xsrf_cookies': False,
    'static_path': os.path.join(BASE_DIRS, "static"),
    "template_path": os.path.join(BASE_DIRS, "template"),
}


if __name__ == "__main__":
    print(settings['static_path'])