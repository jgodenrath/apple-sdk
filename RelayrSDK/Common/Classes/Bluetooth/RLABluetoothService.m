@import CoreBluetooth;                                  // Apple
#import "RLABluetoothService.h"                         // Header
#import "RLABluetoothManager.h"                         // Relayr.framework
#import "RLABluetoothAdapterController.h"               // Relayr.framework

//#import "RLASensorPrivateAPI.h"                         // Relayr.framework (protocol)
//#import "RLADevicePrivateAPI.h"                         // Relayr.framework (protocol)
//#import "RLALocalDevicePrivateAPI.h"                    // Relayr.framework (protocol)
//#import "RLASensorDelegate.h"                           // Relayr.framework (protocol)
//#import "RLAPeripheralnfo.h"                            // Relayr.framework
//#import "RLAMappingInfo.h"                              // Relayr.framework
//#import "RLALocalDevice.h"                              // Relayr.framework
//#import "RLABluetoothPeripheralsDiscoveryRequest.h"     // Relayr.framework (central role)
//#import "RLAWunderbarRegistrationPeripheralRequest.h"   // Relayr.framework (peripheral role)
//#import "RLAColorSensor.h"                              // Relayr.framework (sensor)
//#import "RLAOutput.h"                                   // Relayr.framework (output)

//@interface RLADevice () <RLASensorDelegate>
//@end
//
//@interface RLALocalDevice () <RLADevicePrivateAPI, RLALocalDevicePrivateAPI>
//@end
//
//@interface RLASensor () <RLASensorPrivateAPI>
//@end

@interface RLABluetoothService ()
//@property (strong, nonatomic) RLABluetoothPeripheralsDiscoveryRequest* peripheralRequest;       // Retainer
//@property (strong, nonatomic) RLAWunderbarRegistrationPeripheralRequest* registrationRequest;   // Retainer
@end    // The sole purpose of the retainers is to prevent premature deallocation of the requests

@implementation RLABluetoothService
{
    CBCentralManager* _centralManager;
    RLABluetoothManager* _bleManager;
    RLABluetoothAdapterController* _bleAdapterController;
}

#pragma mark - Public API

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bleManager = [[RLABluetoothManager alloc] init];
        _centralManager = [[CBCentralManager alloc] initWithDelegate:_bleManager queue:nil];
        _bleManager.centralManager = _centralManager;
        _bleAdapterController = [[RLABluetoothAdapterController alloc] init];
    }
    return self;
}

// TODO: Uncomment code
- (void)devicesWithSensorsAndOutputsOfClasses:(NSArray *)classes timeout:(NSTimeInterval)timeout completion:(void(^)(NSArray*, NSError*))completion
{
    RLAErrorAssertTrueAndReturn(completion, RLAErrorCodeMissingArgument);
    
    __autoreleasing NSError* error;
    if ( ![self isBluetoothAvailable:&error] ) { return completion(nil, error); }

    // Setup request
//    self.peripheralRequest = [[RLABluetoothPeripheralsDiscoveryRequest alloc] initWithListenerManager:_bleManager permittedDeviceClasses:classes timeout:timeout];
//    
//    // Execute request
//    __weak typeof(self) weakSelf = self;
//    [self.peripheralRequest executeWithCompletionHandler: ^(NSArray *peripherals, NSError *error) {
//        // Serialize CBPeriphal objects to RLADevices
//        __strong typeof(weakSelf) self = weakSelf;
//        NSArray *devices = [self serializePeripherals:peripherals];
//        
//        // Callback completion block
//        completion(devices, error);
//    }];
}

#pragma mark - Private helpers

- (BOOL)isBluetoothAvailable:(__autoreleasing NSError**)error
{
    if ( _centralManager.state == CBCentralManagerStatePoweredOn ) return YES;
    
    if (error != NULL)
    {
        *error = [RLAError errorWithCode:RLAErrorCodeUnknownConnectionError localizedDescription:@"Could not connect to devices via Bluetooth" failureReason:@"Bluetooth connectity is not available"];
    }
    return NO;
}

// TODO: Uncomment code
- (NSArray*)serializePeripherals:(NSArray *)peripherals
{
    // Setup device objects with all connected peripherals
    NSMutableArray* devices = [NSMutableArray array];
    for (CBPeripheral* peripheral in peripherals) {
        // Init device
//        RLALocalDevice *device = [[RLALocalDevice alloc] initWithPeripheral:peripheral andListenerManager:_bleManager];
//        
//        // Assign sensors to device
//        if (device) {
//            
//            // Assign matching model id to device
//            RLAPeripheralnfo *info = [self.bleAdapterCntrll infoForPeripheralWithName:peripheral.name bleIdentifier:[peripheral.identifier UUIDString] serviceUUID:nil characteristicUUID:nil];
//            RLAErrorAssertTrueAndReturnNil(info, RLAErrorCodeMissingExpectedValue);
//            device.modelID = info.relayrModelID;
//            
//            // Add sensors and connectors to device based on mappings
//            NSArray *mappings = [info mappings];
//            NSMutableArray *mSensors = [NSMutableArray array];
//            NSMutableArray *mOutputs = [NSMutableArray array];
//            for (RLAMappingInfo *info in mappings) {
//                
//                // Setup sensor and delegate in order to receive updates when
//                // objects subscribe for sensor value updates
//                if ([info sensorClass]) {
//                    RLASensor *sensor = [[[info sensorClass] alloc] init];
//                    sensor.delegate = device;
//                    [mSensors addObject:sensor];
//                } else if ([info outputClass]) {
//                    RLAOutput *output = [[[info outputClass] alloc] init];
//                    [mOutputs addObject:output];
//                }
//            }
//            if ([mSensors count]) [device setSensors:[mSensors copy]];
//            if ([mOutputs count]) [device setOutputs:[mOutputs copy]];
//            
//            // Store device
//            [devices addObject:device];
//        }
    }

    return [devices copy];
}

@end