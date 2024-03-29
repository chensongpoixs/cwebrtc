﻿/*
 *  Copyright (c) 2017 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#ifndef MODULES_CONGESTION_CONTROLLER_GOOG_CC_BITRATE_ESTIMATOR_H_
#define MODULES_CONGESTION_CONTROLLER_GOOG_CC_BITRATE_ESTIMATOR_H_

#include <stdint.h>

#include "absl/types/optional.h"
#include "api/transport/webrtc_key_value_config.h"
#include "api/units/data_rate.h"
#include "rtc_base/experiments/field_trial_parser.h"

namespace webrtc {

// Computes a bayesian estimate of the throughput given acks containing
// the arrival time and payload size. Samples which are far from the current
// estimate or are based on few packets are given a smaller weight, as they
// are considered to be more likely to have been caused by, e.g., delay spikes
// unrelated to congestion.
class BitrateEstimator {
 public:
  explicit BitrateEstimator(const WebRtcKeyValueConfig* key_value_config);
  virtual ~BitrateEstimator();
  virtual void Update(int64_t now_ms, int bytes);

  virtual absl::optional<uint32_t> bitrate_bps() const;
  absl::optional<uint32_t> PeekBps() const;

  virtual void ExpectFastRateChange();

 private:
  float UpdateWindow(int64_t now_ms, int bytes, int rate_window_ms);
  int sum_;
  FieldTrialConstrained<int> initial_window_ms_;
  FieldTrialConstrained<int> noninitial_window_ms_;
  FieldTrialParameter<double> uncertainty_scale_;
  FieldTrialParameter<DataRate> uncertainty_symmetry_cap_;
  FieldTrialParameter<DataRate> estimate_floor_;
  int64_t current_window_ms_;
  int64_t prev_time_ms_;
  float bitrate_estimate_kbps_;   // 上一个时刻估计码率
  float bitrate_estimate_var_;    // 上一个时刻估计的？？？
};

}  // namespace webrtc

#endif  // MODULES_CONGESTION_CONTROLLER_GOOG_CC_BITRATE_ESTIMATOR_H_
