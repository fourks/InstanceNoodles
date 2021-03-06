#include "..\..\..\Common\InstanceNoodles.fxh"

StructuredBuffer<float3> bVector;
RWStructuredBuffer<float> RWValueBuffer : BACKBUFFER;


[numthreads(64,1,1)]
void CS_VectorSplit_X(uint3 i : SV_DispatchThreadID)
{
	if (i.x >= threadCount) { return; }	
	RWValueBuffer[i.x] = bVector[i.x % bSize(bVector)].x;
}

[numthreads(64,1,1)]
void CS_VectorSplit_Y(uint3 i : SV_DispatchThreadID)
{
	if (i.x >= threadCount) { return; }	
	RWValueBuffer[i.x] = bVector[i.x % bSize(bVector)].y;
	
}


[numthreads(64,1,1)]
void CS_VectorSplit_Z(uint3 i : SV_DispatchThreadID)
{
	if (i.x >= threadCount) { return; }	
	RWValueBuffer[i.x] = bVector[i.x % bSize(bVector)].z;
	
}



technique11 VectorSplitX
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_VectorSplit_X() ) );
	}
}

technique11 VectorSplitY
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_VectorSplit_Y() ) );
	}
}


technique11 VectorSplitZ
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_VectorSplit_Z() ) );
	}
}


