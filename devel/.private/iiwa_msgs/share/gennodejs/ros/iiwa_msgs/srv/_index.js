
"use strict";

let SetWorkpiece = require('./SetWorkpiece.js')
let SetSmartServoJointSpeedLimits = require('./SetSmartServoJointSpeedLimits.js')
let SetPTPCartesianSpeedLimits = require('./SetPTPCartesianSpeedLimits.js')
let SetPTPJointSpeedLimits = require('./SetPTPJointSpeedLimits.js')
let SetSmartServoLinSpeedLimits = require('./SetSmartServoLinSpeedLimits.js')
let SetEndpointFrame = require('./SetEndpointFrame.js')
let TimeToDestination = require('./TimeToDestination.js')
let SetSpeedOverride = require('./SetSpeedOverride.js')
let ConfigureControlMode = require('./ConfigureControlMode.js')

module.exports = {
  SetWorkpiece: SetWorkpiece,
  SetSmartServoJointSpeedLimits: SetSmartServoJointSpeedLimits,
  SetPTPCartesianSpeedLimits: SetPTPCartesianSpeedLimits,
  SetPTPJointSpeedLimits: SetPTPJointSpeedLimits,
  SetSmartServoLinSpeedLimits: SetSmartServoLinSpeedLimits,
  SetEndpointFrame: SetEndpointFrame,
  TimeToDestination: TimeToDestination,
  SetSpeedOverride: SetSpeedOverride,
  ConfigureControlMode: ConfigureControlMode,
};
