# generate html/typst table with colums and rows labels
# 
using Colors
function render_table(fmt; data=nothing,
    rowlabels=nothing,  # list of labels for rows
    collabels=nothing,  # list of labels for columns
    lulabel="x1/x2",    # upper left cell label
    thcolor=(1, 1, 1),  # color of table header cells
    thbgcolor=(0.5, 0.5, 0.5) # background color of table header cells
)
    rowlabels = collect(rowlabels === nothing ? (1:size(data, 1)) : rowlabels)
    collabels = collect(collabels === nothing ? (1:size(data, 2)) : collabels)

    function htmltable()
        # hex_thcolor = hex(RGB(thcolor...))
        # hex_thbgcolor = hex(RGB(thbgcolor...))
        println("""
            <style>
            .twodimstyle, .twodimstyle th, .twodimstyle td {
                border: 3px solid black;
                border-collapse: collapse;
            }
            .twodimstyle td {
                padding: 4px;
                text-align: center;
            }
            .twodimstyle th {
                padding: 4px;
                text-align: center;
                background-color: #$(hex(RGB(thbgcolor...)));
                color:  #$(hex(RGB(thcolor...)));
            }
            </style>

            <table class="twodimstyle">
            """)
        println("<tr><th>$lulabel</th>")
        for (j, c) in enumerate(collabels)
            println("<th>$c</th>")
        end
        println("</tr>")
        for (i, r) in enumerate(rowlabels)
            println("<tr><th>$r</th>")
            for (j, c) in enumerate(collabels)
                println("<td>$(data[i, j])</td>")
            end
            println("</tr>")
        end
        println("</table>")
    end

    function typsttable()
        function printcell(d, color, bgcolor)
            println("table.cell(fill: rgb(\"#$(hex(RGB(bgcolor...)))\"), inset: 4pt,
            text(fill: rgb(\"#$(hex(RGB(color...)))\"),[$(d)])),")
        end
        colcnt = size(data, 2) + 1
        println("""
            ```{=typst}
                #table(
                columns: $colcnt,
                align: center,
                //columns: (
                //5fr, 10fr, auto, 5fr
                //),
            """)
        printcell(lulabel, thcolor, thbgcolor)
        for (j, c) in enumerate(collabels)
            printcell(c, thcolor, thbgcolor)
        end
        for (i, r) in enumerate(rowlabels)
            printcell(r, thcolor, thbgcolor)
            for (j, c) in enumerate(collabels)
                printcell((data[i, j]), (0, 0, 0), (1, 1, 1))
            end
        end
        println(")")
        println("```")
    end
    if fmt == "html"
        htmltable()
    else
        typsttable()
    end
end