# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.

Crono.perform(JuliaJob).every 1.days, at: '4:04'
