!(function (t) {
    var e = new Date();
    e.setHours(0, 0, 0, 0);
    var n,
        a,
        s = {
            date: null,
            weekDayLength: 1,
            prevButton: "Prev",
            nextButton: "Next",
            monthYearSeparator: " ",
            onClickDate: function (t) { },
            onChangeMonth: function (t) { },
            onClickToday: function (t) { },
            onClickMonthNext: function (t) { },
            onClickMonthPrev: function (t) { },
            onClickYearNext: function (t) { },
            onClickYearPrev: function (t) { },
            onShowYearView: function (t) { },
            onSelectYear: function (t) { },
            showThreeMonthsInARow: !0,
            enableMonthChange: !0,
            enableYearView: !0,
            showTodayButton: !0,
            highlightSelectedWeekday: !0,
            highlightSelectedWeek: !0,
            todayButtonContent: "Today",
            showYearDropdown: !1,
            min: null,
            max: null,
            disable: function (t) { },
        },
        o = !1,
        i = { 1: "january", 2: "february", 3: "march", 4: "april", 5: "may", 6: "june", 7: "july", 8: "august", 9: "september", 10: "october", 11: "november", 12: "december" },
        r = { 0: "sunday", 1: "monday", 2: "tuesday", 3: "wednesday", 4: "thursday", 5: "friday", 6: "saturday" };
    function l(t) {
        var e = t.getMonth() + 1 + " 1 " + t.getFullYear();
        return new Date(e);
    }
    function c(t) {
        return new Date(t.getFullYear(), t.getMonth() + 1, 0);
    }
    function u(t, e) {
        var n = l(t),
            a = n.getDate(),
            s = c(t),
            o =
                (s.getDate(),
                    (function (t) {
                        var e = t.getMonth(),
                            n = t.getFullYear();
                        return 0 === e && ((n -= 1), (e = 12)), new Date(n, e, 0);
                    })(t).getDate()),
            i = [],
            r = n.getDay(),
            u = 1;
        if (1 === e) {
            for (var g = r - 1; g >= 0; g--) {
                var d = new Date(t.getFullYear(), t.getMonth() - 1, o - g);
                i.push(d);
            }
            for (var h = 7 - i.length, f = 0; f < h; f++) {
                d = new Date(n.getFullYear(), n.getMonth(), a + f);
                i.push(d);
            }
        } else
            for (var v = 7 * (e - 1) - r, w = 1; w <= 7; w++)
                if (v + w <= s) {
                    d = new Date(t.getFullYear(), t.getMonth(), v + w);
                    i.push(d);
                } else {
                    d = new Date(t.getFullYear(), t.getMonth() + 1, u++);
                    i.push(d);
                }
        return i;
    }
    function g(t, n) {
        var s = "";
        return (
            (s += '<div class="calendar-box">'),
            o
                ? ((s += '<div class="months-container">'),
                    (s += (function (t) {
                        var e =
                            '<div class="buttons-container">' + (settings.enableMonthChange && settings.enableYearView ? '<button class="prev-button">' + settings.prevButton + "</button>" : "") + '<span class="label-container year-label">';
                        if (settings.showYearDropdown) {
                            e += '<select class="year-dropdown">';
                            for (var n = 1970; n < 2117; n++) n === t.getFullYear() ? (e += '<option selected="selected" value="' + n + '">' + n + "</option>") : (e += '<option value="' + n + '">' + n + "</option>");
                            e += "</select>";
                        } else e += t.getFullYear();
                        return (e += "</span>" + (settings.enableMonthChange && settings.enableYearView ? '<button class="next-button">' + settings.nextButton + "</button>" : "") + "</div>");
                    })(n)),
                    (s += (function (t) {
                        var e = "";
                        for (var n in ((e += '<div class="months-wrapper">'), i))
                            i.hasOwnProperty(n) && (e += '<span class="month' + (settings.showThreeMonthsInARow ? " one-third" : "") + '" data-month="' + n + '" data-year="' + t.getFullYear() + '"><span>' + i[n] + "</span></span>");
                        return (e += "</div>");
                    })(n)),
                    (s += "</div>"))
                : ((s += '<div class="weeks-container">'),
                    (s += (function (t) {
                        return (
                            '<div class="buttons-container">' +
                            (settings.enableMonthChange ? '<button class="prev-button">' + settings.prevButton + "</button>" : "") +
                            '<span class="label-container month-container"><span class="month-label">' +
                            i[t.getMonth() + 1] +
                            "</span>" +
                            settings.monthYearSeparator +
                            '<span class="year-label">' +
                            t.getFullYear() +
                            "</span></span>" +
                            (settings.enableMonthChange ? '<button class="next-button">' + settings.nextButton + "</button>" : "") +
                            "</div>"
                        );
                    })(n)),
                    (s += (function (t) {
                        var e = "";
                        for (var n in ((e += '<div class="weeks-wrapper header">'), (e += '<div class="week" data-week-no="0">'), r))
                            r.hasOwnProperty(n) && (e += '<div class="day header" data-day="' + n + '">' + r[n].substring(0, settings.weekDayLength) + "</div>");
                        return (e += "</div>"), (e += "</div>");
                    })()),
                    (s += (function (t, n) {
                        var s = "";
                        return (
                            (s += '<div class="weeks-wrapper">'),
                            t.forEach(function (t, o) {
                                (s += '<div class="week" data-week-no="' + (o + 1) + '">'),
                                    t.forEach(function (t, o) {
                                        var i = !1;
                                        t.getMonth() !== n.getMonth() && (i = !0), (i = i ? " disabled" : "");
                                        var r = !1;
                                        a ? (t == a.toString() && (r = !0), (r = r ? " selected" : "")) : (r = "");
                                        var l = !1;
                                        t == e.toString() && (l = !0), (l = l ? " today" : "");
                                        var c = "ola";
                                        ((settings.min && settings.min > t) || (settings.max && settings.max < t) || (settings.disable && "function" == typeof settings.disable && settings.disable(t))) && (c = 'disabled="disabled" '),
                                            (s += '<div class="day' + i + r + l + '" data-date="' + t + '" ' + c + " ><span>" + t.getDate() + "</span></div>");
                                    }),
                                    (s += "</div>");
                            }),
                            (s += "</div>")
                        );
                    })(t, n)),
                    (s += "</div>")),
            settings.showTodayButton && (s += '<div class="special-buttons"><button class="today-button">' + settings.todayButtonContent + "</button></div>"),
            (s += "</div>")
        );
    }
    function d(e) {
        var a = (function (t) {
            l(t);
            for (var e = c(t).getDate(), n = c(t).getDate(), a = parseInt(e / 7) + 1, s = [], o = 1; o <= a; o++) s.push(u(t, o));
            var i = s[s.length - 1],
                r = i[i.length - 1].getDate();
            return r < n && n - r < 7 && s.push(u(t, o)), s;
        })(e);
        n.html(g(a, e)),
            settings.highlightSelectedWeekday &&
            (function () {
                var e = n.find(".selected");
                if (e.length > 0) {
                    var a = new Date(e.data("date")).getDay();
                    n.find(".week").each(function (e, n) {
                        t(n)
                            .find(".day:eq(" + (a - 0) + ")")
                            .addClass("highlight");
                    });
                }
            })(),
            settings.highlightSelectedWeek && n.find(".selected").parents(".week").addClass("highlight");
    }
    (t.fn.updateCalendarOptions = function (e) {
        var n = t.extend(settings, e);
        t.fn.calendar.bind(this)(n);
    }),
        (t.fn.calendar = function (i) {
            var r;
            return (
                (settings = t.extend(s, i)),
                settings.min && ((settings.min = new Date(settings.min)), settings.min.setHours(0), settings.min.setMinutes(0), settings.min.setSeconds(0)),
                settings.max && ((settings.max = new Date(settings.max)), settings.max.setHours(0), settings.max.setMinutes(0), settings.max.setSeconds(0)),
                (n = t(this)),
                settings.date ? ((a = "string" == typeof settings.date ? new Date(settings.date) : settings.date).setHours(0, 0, 0, 0), (r = a)) : (r = e),
                d(r),
                settings.enableMonthChange &&
                (n.off("click", ".weeks-container .prev-button").on("click", ".weeks-container .prev-button", function (t) {
                    (r = new Date(r.getFullYear(), r.getMonth() - 1, 1)), settings.onClickMonthPrev(r), d(r);
                }),
                    n.off("click", ".weeks-container .next-button").on("click", ".weeks-container .next-button", function (t) {
                        (r = new Date(r.getFullYear(), r.getMonth() + 1, 1)), settings.onClickMonthNext(r), d(r);
                    })),
                n.off("click", ".day").on("click", ".day", function (e) {
                    var n = t(this).data("date");
                    "disabled" === t(this).attr("disabled") || settings.onClickDate(n);
                }),
                settings.enableMonthChange &&
                settings.enableYearView &&
                (n.off("click", ".month-container").on("click", ".month-container", function (t) {
                    (o = !0), (r = new Date(r.getFullYear(), 0, 1)), settings.onShowYearView(r), d(r);
                }),
                    n.off("click", ".months-container .month").on("click", ".months-container .month", function (e) {
                        var n = t(this),
                            a = n.data("month"),
                            s = n.data("year"),
                            i = new Date(s, a - 1, 1);
                        settings.onChangeMonth(i), (o = !1), d((r = i));
                    }),
                    n.off("click", ".months-container .prev-button").on("click", ".months-container .prev-button", function (t) {
                        (r = new Date(r.getFullYear() - 1, 0, 1)), settings.onClickYearPrev(r), settings.onSelectYear(r), d(r);
                    }),
                    n.off("click", ".months-container .next-button").on("click", ".months-container .next-button", function (t) {
                        (r = new Date(r.getFullYear() + 1, 0, 1)), settings.onClickMonthNext(r), settings.onSelectYear(r), d(r);
                    }),
                    n.off("change", ".months-container .year-dropdown").on("change", ".months-container .year-dropdown", function (e) {
                        var n = t(this).val();
                        (r = new Date(n, 0, 1)), settings.onSelectYear(r), d(r);
                    })),
                settings.showTodayButton &&
                n.off("click", ".today-button").on("click", ".today-button", function (t) {
                    (r = e), (a = e), settings.onClickToday(e), (o = !1), d(r);
                }),
                this
            );
        });
})(jQuery);
