"""."""

import os

import matplotlib.gridspec as gridspec
import matplotlib.pyplot as plt
import numpy as np

SCRIPT_ABS_DIR = os.sys.path[0]
os.sys.path.append(os.path.join(SCRIPT_ABS_DIR, '../../config'))
import my_py_picture as config  # noqa

figure_width = config.MAX_FULL_PAGE_WIDTH * 0.8
FIGSIZE = (figure_width, figure_width * 0.3)
DPI = config.DPI_GRAPH
LAYOUT = dict(pad=0, h_pad=0, w_pad=2, rect=(0, 0, 1, 1))
PLOTS_WIDTH_RATIOS = [0.6, 1]
LABEL_OPTIONS = dict(config.LABEL_OPTIONS, x=0.03, y=1)

X_LABEL = 'Cuteness'
Y_LABEL = 'Excitement'


def main():
    """."""
    x_a = np.linspace(0, 10, num=10)
    y_a = [0] + [1] * 9
    x_b = np.linspace(0, 10, num=10)
    y_b = np.linspace(0, 10, num=10)

    fig = plt.figure(figsize=FIGSIZE, dpi=DPI)
    gs = gridspec.GridSpec(1, 2, width_ratios=PLOTS_WIDTH_RATIOS)

    ax_a = fig.add_subplot(gs[0])
    ax_a.plot(x_a, y_a)
    ax_a.set_xlabel(X_LABEL)
    ax_a.set_ylabel(Y_LABEL)
    ax_a.text(s=r'\textbf{a}', transform=ax_a.transAxes, **LABEL_OPTIONS)

    ax_b = fig.add_subplot(gs[1])
    ax_b.plot(x_b, y_b)
    ax_b.set_xlabel(X_LABEL)
    ax_b.set_ylabel(Y_LABEL)
    ax_b.text(s=r'\textbf{b}', transform=ax_b.transAxes, **LABEL_OPTIONS)

    fig.tight_layout(**LAYOUT)
    fig.savefig(config.get_figure_file_path(os.sys.argv[0]))
    plt.close(fig)


if __name__ == '__main__':
    main()
