(declare-project
  :name "dtgb"
  :description "A datetime grab bag of functions"
  :dependencies ["https://github.com/andrewchambers/janet-sh.git"
                 "https://github.com/pyrmont/testament"])

(declare-source
  :source ["diff.janet"
           "dtgb.janet"
           "epoch.janet"
           "unix.janet"
           "util.janet"])
