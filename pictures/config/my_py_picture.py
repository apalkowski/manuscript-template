"""Configuration file for producing Matplotlib graphics."""

__all__ = [
    'LABEL_OPTIONS', 'IN_PER_MM', 'MAX_FULL_PAGE_WIDTH', 'MAX_HALF_PAGE_WIDTH',
    'DPI_COLOR_PHOTO', 'DPI_GRAYSCALE_PHOTO', 'DPI_GRAPH',
    'get_figure_file_path'
]

import locale
import os
import platform
import re
import shutil

import matplotlib as mpl

main_font_size = 8
label_font_size = 9
LABEL_OPTIONS = dict(color='black', size=label_font_size, va='top', ha='left')

max_full_page_width_mm = 150
max_half_page_width_mm = 70
IN_PER_MM = 1 / 25.4
MAX_FULL_PAGE_WIDTH = max_full_page_width_mm * IN_PER_MM  # (in)
MAX_HALF_PAGE_WIDTH = max_half_page_width_mm * IN_PER_MM  # (in)

use_tex = True
tex_lang = 'british'

figure_file_ext = '.pdf'
figure_file_dir = '../'

DPI_COLOR_PHOTO = 300
DPI_GRAYSCALE_PHOTO = 600
DPI_GRAPH = 1200

tex_preamble_math = [
    r'\usepackage{mathtools}',
    r'\newcommand*{\imgunit}{\ensuremath{\mathrm{i}}}'
]
tex_preamble_sfmath = [r'\usepackage{sfmath}']
tex_preamble_lang = [r'\usepackage[' + tex_lang + ']{babel}']
tex_main_font = (
    r'\usepackage[scaled=1.111111]{newtxtext}' + r'\usepackage{newtxmath}')
tex_fonts = (r'\usepackage[T1]{fontenc}' + r'\usepackage[utf8]{inputenc}' +
             tex_main_font + r'\usepackage[varl]{inconsolata}')
tex_preamble_siunitx = [
    r'\usepackage[binary-units]{siunitx}', r'\sisetup{per-mode=symbol}',
    r'\sisetup{group-separator={,}}', r'\sisetup{group-digits=integer}',
    r'\sisetup{group-minimum-digits=4}',
    r'\sisetup{list-final-separator={, and }}', r'\sisetup{range-phrase={--}}',
    r'\sisetup{list-units=single}', r'\sisetup{range-units=single}',
    r'\sisetup{detect-all}', r'\ExplSyntaxOn',
    (r'\cs_new_eq:NN \siunitx_table_collect_begin:Nn ' +
     r'\__siunitx_table_collect_begin:Nn'), r'\ExplSyntaxOff',
    (r'\DeclareSIUnit[number-unit-product={},list-units=repeat,' +
     r'range-units=repeat]\percent{\%}')
]
tex_preamble_tables = [
    r'\usepackage{array}', r'\usepackage[table,fixpdftex]{xcolor}',
    r'\usepackage{longtable}', r'\usepackage[referable]{threeparttablex}',
    r'\renewcommand{\TPTLnotesnamefontcommand}{}', r'\usepackage{tabu}',
    r'\tabulinesep=1ex', r'\usepackage{booktabs}'
]
tex_preamble_other = [
    r'\usepackage{enumitem}', r'\setlist{noitemsep}', r'\usepackage{csquotes}',
    r'\usepackage{hyphenat}', r'\usepackage{microtype}',
    r'\microtypesetup{babel=true}'
]
tex_preamble = (tex_preamble_math + tex_preamble_lang + tex_preamble_siunitx +
                tex_preamble_tables + tex_preamble_other + tex_preamble_sfmath)

opsys = platform.system()
if opsys == 'Windows':
    lang = 'en'
else:
    lang = 'en_GB.utf8'
locale.setlocale(locale.LC_ALL, lang)

mpl.rcdefaults()

mpl.style.use('tableau-colorblind10')
mpl.rcParams['image.cmap'] = 'cividis'

mpl.rcParams['font.size'] = main_font_size
mpl.rcParams['axes.labelsize'] = main_font_size
mpl.rcParams['xtick.labelsize'] = main_font_size
mpl.rcParams['ytick.labelsize'] = main_font_size
mpl.rcParams['legend.fontsize'] = main_font_size
mpl.rcParams['axes.titlesize'] = main_font_size
mpl.rcParams['figure.titlesize'] = main_font_size

mpl.rcParams['axes.formatter.use_locale'] = True

mpl.rcParams['axes.spines.top'] = False
mpl.rcParams['axes.spines.right'] = False

axis_color = '0.15'
mpl.rcParams['text.color'] = axis_color
mpl.rcParams['axes.labelcolor'] = axis_color
mpl.rcParams['xtick.color'] = axis_color
mpl.rcParams['ytick.color'] = axis_color
mpl.rcParams['axes.edgecolor'] = axis_color

mpl.rcParams['axes.axisbelow'] = True

mpl.rcParams['text.usetex'] = use_tex
mpl.rcParams['text.latex.preamble'] = tex_preamble

if use_tex:
    shutil.rmtree(mpl.texmanager.TexManager.texcache)
    myfonts_name = 'myfonts'
    mpl.texmanager.TexManager.font_info[myfonts_name] = (myfonts_name,
                                                         tex_fonts)
    sansfonts = mpl.rcParams['font.sans-serif']
    mpl.rcParams['font.sans-serif'] = [myfonts_name] + sansfonts


def get_figure_file_path(script_path):
    """Return absolute path to a figure file to be generated.

    Parameters
    ----------
    script_path : str
        Path to the script file that generates the figure.

    """
    figure_file = re.findall('(.+).py',
                             os.path.basename(script_path))[0].replace(
                                 '_', '-') + figure_file_ext
    script_abs_dir = os.path.dirname(os.path.abspath(script_path))
    return os.path.join(script_abs_dir, figure_file_dir + figure_file)
