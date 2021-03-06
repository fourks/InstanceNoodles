#include "..\..\..\Common\InstanceNoodles.fxh"

StructuredBuffer<float> InputBuffer, compareBuffer; 
float compareValue;

//Output buffer
RWStructuredBuffer<float> RWOutputBuffer : BACKBUFFER; 

[numthreads(64,1,1)]
void CS_Equal(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value == compare;
}

[numthreads(64,1,1)]
void CS_NotEqual(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value != compare;
}

[numthreads(64,1,1)]
void CS_Less(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value < compare;
}

[numthreads(64,1,1)]
void CS_LessEqual(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value <= compare;
}

[numthreads(64,1,1)]
void CS_Greater(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value > compare;
}

[numthreads(64,1,1)]
void CS_GreaterEqual(uint3 dtid : SV_DispatchThreadID)
{
	if (dtid.x >= threadCount) { return; }
	
	float compare = bLoad(compareBuffer, compareValue, dtid.x);
	float value = bLoad(InputBuffer, 0, dtid.x);
	RWOutputBuffer[dtid.x] = value >= compare;
}
technique11 Equal
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Equal() ) );
	}
}

technique11 NotEqual
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_NotEqual() ) );
	}
}

technique11 Less
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Less() ) );
	}
}

technique11 LessEqual
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_LessEqual() ) );
	}
}

technique11 Greater
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Greater() ) );
	}
}

technique11 GreaterEqual
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_GreaterEqual() ) );
	}
}





