import os
import sys
sys.path.insert(0, os.path.abspath('..'))


# -- Project information -----------------------------------------------------

project = 'yapt'
copyright = '2021, Caian R. Ertl'
author = 'Caian R. Ertl'

# The full version, including alpha/beta/rc tags
release = '0.1.0'


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = []


# -- Options for HTML output -------------------------------------------------

html_logo = 'logo.svg'
html_title = 'yapt'
html_theme = 'sphinx_book_theme'

html_theme_options = {
    'repository_url': 'https://github.com/caian-org/yapt',
    'use_repository_button': True,
    'show_toc_level': 3
}


# -- Configs & Other Stuff ---------------------------------------------------
