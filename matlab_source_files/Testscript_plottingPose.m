close all


tp = theaterPlot('XLimit',[-1 1],'YLimit',[-1 1],'ZLimit',[-1 1]);
op =orientationPlotter(tp);
plotOrientation(op,0,0,0)

tp = theaterPlot('XLimit',[-1 1],'YLimit',[-1 1],'ZLimit',[-1 1]);
op =orientationPlotter(tp);
plotOrientation(op,0,0,45)


tp = theaterPlot('XLimit',[-1 1],'YLimit',[-1 1],'ZLimit',[-1 1]);
op =orientationPlotter(tp);
plotOrientation(op,0,0,-45)

