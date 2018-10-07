"""."""

import os

import matplotlib.pyplot as plt
import numpy as np

SCRIPT_ABS_DIR = os.sys.path[0]
os.sys.path.append(os.path.join(SCRIPT_ABS_DIR, '../../config'))
import my_py_picture as config  # noqa

figure_width = config.MAX_HALF_PAGE_WIDTH * 0.9
FIGSIZE = (figure_width, figure_width * 0.7)
DPI = config.DPI_GRAPH
LAYOUT = dict(pad=0, h_pad=0, w_pad=0, rect=(0, 0, 1, 1))

X_LABEL = r'Time (\si{\second})'
Y_LABEL = r'Price (\$)'


def main():
    """."""
    x = np.linspace(0, 100, num=20)
    y = np.logspace(2, 10, num=20, base=2)

    fig = plt.figure(figsize=FIGSIZE, dpi=DPI)

    ax = fig.add_subplot(111)
    ax.plot(x, y)
    ax.set_xlabel(X_LABEL)
    ax.set_ylabel(Y_LABEL)

    fig.tight_layout(**LAYOUT)
    fig.savefig(config.get_figure_file_path(os.sys.argv[0]))
    plt.close(fig)


if __name__ == '__main__':
    main()
