#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import nltk
import os
import sys
import ssl
#from editor.models import Singleton

def main():
    try:
        _create_unverified_https_context = ssl._create_unverified_context
    except AttributeError:
        pass
    else:
        ssl._create_default_https_context = _create_unverified_https_context

    nltk.download()
    nltk.download('punkt')
    nltk.download('wordnet')
    nltk.download('omw')
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'thesaurus.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Hey From Altosh Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc

    execute_from_command_line(sys.argv)



if __name__ == '__main__':
    main()

