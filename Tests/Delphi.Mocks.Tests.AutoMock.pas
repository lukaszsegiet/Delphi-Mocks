unit Delphi.Mocks.Tests.AutoMock;

interface

uses
  SysUtils,
  TestFramework,
  Delphi.Mocks;

type
  {$M+}
  TReturnedObject = class(TObject)
  end;

  IReturnedInterface = interface
    ['{8C9AA0D8-5788-4B40-986A-46422BB05E9A}']
  end;

  IReturnedInterfaceWhichAlsoReturns = interface
    ['{8E3D166F-ED6A-40D9-8C0A-4EC8FF969AF9}']
  end;

  IAutoMockedInterface = interface
    ['{CC254E0F-63D0-49CB-9918-63AE5D388842}']
    function FuncToReturnInterface : IReturnedInterface;
    function FuncToReturnClass : TReturnedObject;
    function FuncToReturnInterfaceWhichAlsoReturn : IReturnedInterfaceWhichAlsoReturns;
  end;
  {$M-}

  TAutoMockTests = class(TTestCase)
  published
    procedure AutoMock_Can_Mock_Interface;
    procedure AutoMock_Automatically_Mocks_Contained_Returned_Interface;
  end;

implementation

{ TAutoMockTests }

procedure TAutoMockTests.AutoMock_Automatically_Mocks_Contained_Returned_Interface;
var
  automockSUT : TAutoMockContainer;
  mock : TMock<IAutoMockedInterface>;
  mockInterface : IReturnedInterface;
  mockObject : TReturnedObject;
begin
  automockSUT := TAutoMockContainer.Create;

  mock := automockSUT.Mock<IAutoMockedInterface>;

  mockInterface := mock.Instance.FuncToReturnInterface;
  mockObject := mock.Instance.FuncToReturnClass;

  CheckNotNull(mockInterface, 'Expected the interface off the mock to be auotmatically created and the instance returned.');
  CheckNotNull(mockObject, 'Expected the object off the mock to be auotmatically created and the instance returned.');
end;

procedure TAutoMockTests.AutoMock_Can_Mock_Interface;
var
  automockSUT : TAutoMockContainer;
  mock : TMock<IAutoMockedInterface>;
begin
  automockSUT := TAutoMockContainer.Create;

  mock := automockSUT.Mock<IAutoMockedInterface>;

  CheckNotNull(mock.Instance, 'Expect the interface returned from mock is not null');
end;

initialization
  TestFramework.RegisterTest(TAutoMockTests.Suite);

end.